class Organization < ActiveRecord::Base
  validates_presence_of :name, :address_city, :address_state

  def geocode
    require 'rexml/document'
    require 'open-uri'   

    address_line1_value = (address_line1 unless address_line1.blank?) || ""
    address_line1_value = address_line1_value + ", " unless address_line1_value.blank?
    address = address_line1_value + address_city + ", " + address_state
    address << (" " + address_zip[0..4]) unless address_zip.blank?
    uri = "http://maps.google.com/maps/geo?q=" << URI::encode(address) << "&output=xml&key=#{Radiant::Config['directory.google_map_key']}"
    response = open(uri).read
    response = REXML::Document.new(response)
    status = response.elements['kml/Response/Status/code'].text

    if status == "200"
      self.lng, self.lat = response.elements['kml/Response/Placemark/Point/coordinates'].text.split(",").collect { |s| s.to_f }
      self.save
      return true
    else
      self.errors.add_to_base("Geocoding failed. Check the address.")
      return false
    end
  end

  def phone_formatted
    number_to_phone(phone)
  end

  def address_zip_formatted
    zip = address_zip[0..4]
    zip.concat("-" << address_zip[5..8]) unless address_zip[5..8].blank?
    return zip
  end
             
  class << self   

    def geocode_all
      find(:all).each do |o|
        o.geocode
      end
    end
       
    def find_all_by_point_and_radius(lat, lng, radius)
      #make sure we have valid parameters
      radius = radius.to_f  #convert radius to float
      latitude_miles = 69.172  #this is constant
      #longitude miles varies based on latitude, that is calculated here
      longitude_miles = (latitude_miles * 
                           Math.cos(lat * (Math::PI/180))).abs
      latitude_degrees = radius/latitude_miles  #radius in degrees latitude
      longitude_degrees = radius/longitude_miles  #radius in degrees longitude

      #now set min and max lat and long accordingly
      min_latitude = lat - latitude_degrees
      max_latitude = lat + latitude_degrees
      min_longitude = lng - longitude_degrees
      max_longitude = lng + longitude_degrees
  
      #now find all Orgs codes that are within 
      #these min/max lat/long bounds and return them
      #weed out any zip codes that fall outside of the search box
      return DirectoryOrg.find(:all,
            :select => "*, sqrt( pow(#{latitude_miles} *
                                (lat-#{lat}),2) + 
                              pow(#{longitude_miles} * 
                                (lng-#{lng}),2)) 
                              as distance",
            :conditions => "(lat BETWEEN #{min_latitude} 
                              AND #{max_latitude}) 
                            AND (lng BETWEEN #{min_longitude} 
                              AND #{max_longitude}) 
                            AND sqrt(pow(#{latitude_miles} * 
                              (lat-#{lat}),2) + 
                              pow(#{longitude_miles} * 
                                (lng-#{lng}),2)) 
                              <= #{radius}",
            :order => "distance")
    end  
         
  end  
  
private

  # straight out of ActionController...
  def number_to_phone(number, options = {})
    number       = number.to_s.strip unless number.nil?
    options      = options.stringify_keys
    area_code    = options["area_code"] || nil
    delimiter    = options["delimiter"] || "-"
    extension    = options["extension"].to_s.strip || nil
    country_code = options["country_code"] || nil

    begin
      str = ""
      str << "+#{country_code}#{delimiter}" unless country_code.blank?
      str << if area_code
        number.gsub!(/([0-9]{1,3})([0-9]{3})([0-9]{4}$)/,"(\\1) \\2#{delimiter}\\3")
      else
        number.gsub!(/([0-9]{1,3})([0-9]{3})([0-9]{4})$/,"\\1#{delimiter}\\2#{delimiter}\\3")
      end
      str << " x #{extension}" unless extension.blank?
      str
    rescue
      number
    end
  end
  
end
