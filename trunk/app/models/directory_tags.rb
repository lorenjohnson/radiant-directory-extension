class DirectoryTags < Page

  desc %{ Directory root node. }
  tag "directory" do |tag|
    tag.expand
  end

  desc %{ Directory Google Map. Relies on setting in Radiant::Config['directory.google_map_key'] for authorizing to the Google Maps API. Responds to search forms for Proximity Search. }
  tag "directory:map" do |tag|
    content = %{
      <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=#{Radiant::Config['directory.google_map_key']}" type="text/javascript"></script>
    	<script src="/assets/template/scripts/directory.js" type="text/javascript"></script> 
      <div id="map"></div> }
    content << %{ <script type="text/javascript">search_address="#{@proximity_search_address}"</script> } unless @proximity_search_address.blank?
    content
  end

  tag "directory:results" do |tag|
    tag.expand
  end

  desc %{ Directory search results. }
  tag "directory:results:each" do |tag|
    content = ''
    @map_markers = []
    @orgs.each do |org|
      unless org.lat.blank? or org.lng.blank?
        lat = org.lat.to_f
        lng = org.lng.to_f
      else
        lat = false
        lng = false
      end
      @map_markers << [lat,lng,org.name, "infoWindow_" + org.id.to_s, "result_" + org.id.to_s]
      tag.locals.org = org
      content << tag.expand
    end
    content << %{ <script type="text/javascript">points_array = #{@map_markers.to_json}</script> }
  end
   
  desc %{ Count of items in current search results set. }
  tag "directory:results:count" do |tag|
    @orgs.nitems 
  end
  
  begin
    Organization.column_names.each do |column|
      desc %{ Display directory #{column}.  }
      tag "directory:#{column}" do |tag|
        hash = tag.locals.org
        hash[column].to_s
      end
      tag "directory:if_#{column}" do |tag|
        hash = tag.locals.org
        tag.expand unless hash[column].blank?      
      end
    end
  rescue
  end
  
  desc %{ Displays the formatted phone number. }
  tag "directory:phone" do |tag|
    tag.locals.org.phone_formatted
  end 

  desc %{ Displays the formatted zip code. }
  tag "directory:address_zip" do |tag|
    tag.locals.org.address_zip_formatted
  end 
  
  desc %{ Creates a link to the website for this result. If no website_url exists nothing is generated. Tag has a class attribute for injecting a CSS class on the generated link.
    
          Usage:
          <pre><code>
          <r:directory:website_link [class=""] />
          </code></pre> }
  tag "directory:website_link" do |tag|
    %{ 
       <a href="http://#{tag.locals.org.website_url}" class="#{tag.attr['class']}">
         #{tag.expand}
       </a> 
      } unless tag.locals.org.website_url.blank?
  end 

  desc %{ Creates a dirving directions link for this result. Assembles starting address from current result and ending address is captured from proximity search fields. If no proximity search has been initated or implemented the link will just go to Google Maps with the result's address. Tag has a class attribute for injecting a CSS class on the generated link.
    
          Usage:
          <pre><code>
          <r:directory:directions_links [class=""] />
          </code></pre> }
  tag "directory:directions_link" do |tag|
    starting_address = %{#{tag.locals.org.address_line1},#{tag.locals.org.address_city},#{tag.locals.org.address_state} #{tag.locals.org.address_zip}}
    destination_address = ""
    destination_address = @proximity_search_address unless @proximity_search_address.blank?
    %{
      <a href="http://maps.google.com/maps?f=d&amp;hl=en&amp;saddr=#{starting_address}&amp;daddr=#{destination_address}&amp;ie=UTF8&amp;om=1" class="#{tag.attr['class']}">
       #{tag.expand}
     </a>
    }
  end
  
  desc %{ A simple logic tag for switching parts of the results on/off based on whether a proximity search address is present or not. }  
  tag "directory:if_distance" do |tag|
    tag.expand unless @proximity_search_address.blank? 
  end

  desc %{ Shows distance from starting address to this result, assumes a proximity search has ben issued. }
  tag "directory:distance" do |tag|
   format_string = tag.attr['format'].blank? ? "%.1f miles" : tag.attr['format']
   format_string % tag.locals.org.distance unless @proximity_search_address.blank? 
  end

  desc %{ Directory Search By Name Form Tags }
  tag "directory:search" do |tag|
    tag.expand
  end
  tag "directory:search:query" do |tag|
    unless @name_search.blank? 
      @name_search
    end 
    unless @proximity_search_address.blank? 
      @proximity_search_address
    end 
    unless @proximity_search_distance.blank? 
      @proximity_search_distance
    end 
  end
  tag "directory:search:by_name" do |tag|
    tag.expand
  end
  tag "directory:search:by_name:form" do |tag|
    %{
  	<form id="nameSearchForm" name="nameSearchForm" class="#{tag.attr['class']}" method="get">
      #{tag.expand}
  	</form>
    }
  end
  tag "directory:search:by_name:name_field" do |tag|
    current_value = @name_search
   	  %{
   	   <input id="nameSearch" name="nameSearch" type="text" value="#{current_value}" />  
   	  }   
  end
  tag "directory:search:by_name:submit_button" do |tag|
    %{
      <input id="searchByNameButton" type="submit" value="Search" />
    }
  end
  tag "directory:search:by_proximity" do |tag|
    tag.expand
  end
  tag "directory:search:by_proximity:form" do |tag|
    %{
  	<form id="proximitySearchForm" name="proximitySearchForm" class="#{tag.attr['class']}" method="get">
      #{tag.expand}
  	</form>
    }  
  end
  tag "directory:search:by_proximity:address_field" do |tag|
    current_value = @proximity_search_address
    %{ <input id="proximitySearchAddress" name="proximitySearchAddress" type="text" value="#{current_value}" /> }   
  end
  tag "directory:search:by_proximity:distance_field" do |tag|
    default_value = tag.attr["default_value"].blank? ? 5 : tag.attr["default_value"]
    current_value = @proximity_search_distance.blank? ? default_value : @proximity_search_distance
   	content = %{<select id="proximitySearchDistance" name="proximitySearchDistance">}
    options = tag.attr['options'].blank? ? [["2 Miles",2],["5 Miles",5],["10 Miles",10],["20 Miles",20],["All",10000]] : tag.attr['options']
    options.each do |text, value|
      content << %{<option value="#{value}"#{' selected="selected"' if value == current_value.to_i}>#{text}</option>}  
   	end 
    content << "</select>"
  end
  tag "directory:search:by_proximity:submit_button" do |tag|
    %{
      <input id="searchByProximityButton" type="submit" value="Search" />
    }
  end
  
  def cache?
    false
  end

  def process(request,response)
    @name_search = request.parameters["nameSearch"]
    @proximity_search_address = request.parameters["proximitySearchAddress"]
    @proximity_search_distance = request.parameters["proximitySearchDistance"]
    @map_markers = ""

    unless @name_search.blank? then
      @orgs = Organization.find(:all, :conditions => ["name LIKE ?", "%#{@name_search}%"], :order => "name ASC"  )
    else 
      unless @proximity_search_address.blank? 
        @proximity_search_distance = 1000 if @proximity_search_distance.blank?  
        lat, lng = geocode(@proximity_search_address)
        @orgs = Organization.find_all_by_point_and_radius(lat, lng, @proximity_search_distance)
      else 
        @orgs = Organization.find(:all, :order => "name ASC")
      end    
    end    

    super
  end

  def geocode(address)
    require 'rexml/document'
    require 'open-uri'   
    uri = "http://maps.google.com/maps/geo?q=#{URI::encode(address)}&output=xml&key=#{Radiant::Config["directory.google_map_key"]}"
    response = open(uri).read
    response = REXML::Document.new(response)
    lng, lat  = response.elements['kml/Response/Placemark/Point/coordinates'].text.split(",").collect { |s| s.to_f }   
    return [lat, lng]
  end

  
end

