class DirectoryTags < Page
  # <style type="text/css" media="screen">
  #   @import url("/directory_extension/stylesheets/directory.css");
  # </style>
  # <!--[if IE]>
  #   <style type="text/css" media="screen">
  #     @import url("/directory_extension/stylesheets/directory_ie.css");
  #   </style>
  # <![endif]-->

  tag "directory" do |tag|
    tag.expand
  end
  tag "directory:map" do |tag|
    %{
      <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAKsmqeCs1JL6iKytv5zPbWRR3kDcvJrVMbmPglKyZN_EpR3_VZBTOpBNdX5K17k8MNdgBFu9RmP7szw" type="text/javascript"></script>
    	<script src="/directory_extension/scripts/directory.js" type="text/javascript"></script> 
      <div id="map"></div>
    }
  end
  tag "directory:results" do |tag|
    tag.expand
  end
  # Directory Search Results
  tag "directory:results:each" do |tag|
    content = ''
    @orgs.each do |org|
      unless org.lat.blank? or org.lng.blank?
        @map_markers << 
        %{
          map_add_point(#{org.lat},#{org.lng});
        }
      end
      # ,$('content#{org.id}').innerHTML
      tag.locals.org = org
      content << tag.expand
    end
    content << 
    %{ 
      <script type="text/javascript">
        function add_markers() {
          #{@map_markers}
        }
      </script>      
      }
    content
  end

  tag "directory:results:count" do |tag|
    @orgs.nitems
  end
  DirectoryOrg.column_names.each do |column|
    desc %{ <r:directory:#{column} /> }
    tag "directory:#{column}" do |tag|
      hash = tag.locals.org
      hash[column].to_s
    end
  end
  
  # Directory Search By Name Form Tags
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
  	<form id="nameSearchForm" name="nameSearchForm" method="get">
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
  	<form id="proximitySearchForm" name="proximitySearchForm" method="get">
      #{tag.expand}
  	</form>
    }  
  end
  tag "directory:search:by_proximity:address_field" do |tag|
    current_value = @proximity_search_address
	  %{
	   <input id="proximitySearchAddress" name="proximitySearchAddress" type="text" value="#{current_value}" />  
	  }   
  end
  tag "directory:search:by_proximity:distance_field" do |tag|
    current_value = @proximity_search_distance
	  %{
	   <input id="proximitySearchAddress" name="proximitySearchDistance" type="text" value="#{current_value}" />  
	  }   
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
      @orgs = DirectoryOrg.find(:all, :conditions => ["name LIKE ?", "%#{@name_search}%"]  )
    else 
      unless @proximity_search_address.blank? 
        @proximity_search_distance = 5 if @proximity_search_distance.blank?  
        latlng = geocode(@proximity_search_address)
        @orgs = DirectoryOrg.find_all_by_point_and_radius(latlng[0], latlng[1], @proximity_search_distance)
      else 
        @orgs = DirectoryOrg.find(:all)
      end    
    end    

    super
  end

  # def render
  #   # if @request.post?
  #   # if !@request.path_parameters[:distance].blank? and !@request.path_parameters[:addressSearch].blank? then
  #   #   latlng = geocode(params[:addressSearch])
  #   #   @orgs = DirectoryOrg.find_by_point_and_radius(latlng[0],latlng[1],@request.path_parameters[:distance].to_i)
  #   #   @lat, @lng = latlng[0], latlng[1]
  #   # end
  #   super
  # end  

  def geocode(address)
    # require 'uri'
    # require 'net/http'
    require 'rexml/document'
    require 'open-uri'   
    
    uri = "http://maps.google.com/maps/geo?q=" << URI::encode(address) << "&output=xml&key=ABQIAAAAKsmqeCs1JL6iKytv5zPbWRQyt0jC_m_YyhurHdIvODC7HA1gCxRx5WLtgBIyCDw0ay51LSUcOzBjcA"
    response = open(uri).read
    response = REXML::Document.new(response)
    lng, lat  = response.elements['kml/Response/Placemark/Point/coordinates'].text.split(",").collect { |s| s.to_f }   
    # @debug = [lat, lng]
    return [lat, lng]
  end
  
  
  # description %{
  #   Directory tags to create a searchable directory within Radiant.
  # }
  # 
  # desc %{ <r:directory /> 
  #         drop the whole church finder end-user application where this tag is placed 
  #       }
  # tag "directory:map" do |tag|
  #   %{
  #     <div id="map"></div>
  #   }
  # end
  # tag "directory:search" do |tag|
  #   tag.expand
  # end
  # tag "directory:search:by_name" do |tag|
  #   %{
  #     <form id="nameSearchForm" name="nameSearchForm" onsubmit="javascript:searchByName($('nameSearch')); return false;">
  # 			<label for="nameSearch">Search by Name</label>
  # 			<input type="text" id="nameSearch" name="nameSearch" onkeyup="" />
  # 			<input id="searchByNameButton" name="searchByNameButton" type="button" onClick="javascript:searchByName();" value="Search" />
  # 		</form>
  # 		}
  # end
  # tag "directory:search:by_deanery" do |tag|
  #   %{
  #   	<form id="deanerySearchForm" name="deanerySearchForm" onsubmit="javascript:searchByDeanery($('deanerySearch')); return false;">
  #   		<label for="deanerySearch">Search by Deanery</label>
  #   		<select name="deanerySearch" id="deanerySearch" >	
  #   			<option value=""></option>
  #   			<option value="Brandywine">Brandywine</option>
  #   			<option value="Bucks">Bucks</option>
  #   			<option value="Conestoga">Conestoga</option>	
  #   			<option value="Delaware">Delaware</option>	
  #   			<option value="Merion">Merion</option>
  #   			<option value="Montgomery">Montgomery</option>
  #   			<option value="Pennypack">Pennypack</option>
  #   			<option value="Schuylkill">Schuylkill</option>
  #   			<option value="Southwark">Southwark</option>
  #   			<option value="Valley Forge">Valley Forge</option>
  #   			<option value="Wissahickon">Wissahickon</option>
  #   		</select>
  #   		<input id="searchByDeaneryButton" name="searchByDeaneryButton" type="button" onClick="javascript:searchByDeanery();" value="Search" />
  #   	</form>
  # 	}
  # end
  # tag "directory:search:by_address" do |tag|
  #   %{
  #     <form id="addressSearchForm" name="addressSearchForm" onsubmit="javascript: return false;">
  # 			<label for="addressSearch">Show Churches Near Your Address</label>
  # 			<input type="text" id="addressSearch" name="addressSearch" />
  # 			<input id="searchbyAddress" name="searchbyAddress" type="button" onClick="javascript:showChurchesNearAddress($F(addressSearch),$F(addressSearch),blueicon,11);" value="Search" />
  # 		</form>
  # 		%}
  # end
  # tag "directory:search_results" do |tag|
  #   %{
  #     <div id="resultsPanel">
  #   		<div id="searchResultsLabel">Search Results</div>
  #   		<div id="status"></div>
  #   		<div id="searchResults"></div>
  #   	</div>
  #   }
  # end
  
  # require 'open-uri'
  # open("http://localhost:3020/church_finder_source").read    
  # 
  # tag 'external_content' do |tag|
  #   require 'open-uri'
  #  
  #   open(tag.attr['url']).read
  # end
  
  # def process(request, response)  
  #   @request, @response = request, response
  #   if valid_post?
  #     response.redirect parent.url
  #     request, response = nil, nil
  #   else
  #     response.redirect parent.url
  #   end
  # end
  
end

