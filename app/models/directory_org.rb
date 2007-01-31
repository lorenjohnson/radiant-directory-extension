class DirectoryOrg < ActiveRecord::Base
  belongs_to :directory_deanery
  attr :distance

  def DirectoryOrg.find_all_by_point_and_radius(lat, lng, radius)
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
