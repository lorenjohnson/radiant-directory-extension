class DirectorySearch
  attr_accessor :name, :from_address, :max_distance, :category, :from_lat, :from_lng
  
  def initialize
  end
  
  def execute
    unless @name.blank? then
      @orgs = DirectoryOrg.find(:all, :conditions => ["name LIKE ?", "%#{@name}%"], :order => "name ASC"  )
    else 
      if !@from_lat.blank? && !@from_lng.blank?
        @max_distance = 1000 if @max_distance.blank?
        lat, lng = geocode(@from_address)
        @orgs = DirectoryOrg.find_all_by_point_and_radius(@from_lat, @from_lng, @max_distance)
      elsif !@category.blank?
        @orgs = DirectoryOrg.find_all_by_category(@category, :order => "name ASC")
      else 
        @orgs = DirectoryOrg.find(:all, :order => "name ASC")
      end    
    end    
  end

  def from_address=(address)
    @from_address = address
    require 'rexml/document'
    require 'open-uri'   
    uri = "http://maps.google.com/maps/geo?q=#{URI::encode(address)}&output=xml&key=#{Radiant::Config["directory.google_map_key"]}"
    response = open(uri).read
    response = REXML::Document.new(response)
    @from_lng, @from_lat  = response.elements['kml/Response/Placemark/Point/coordinates'].text.split(",").collect { |s| s.to_f }       
  end

end