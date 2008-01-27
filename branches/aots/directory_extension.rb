class DirectoryExtension < Radiant::Extension
  version "0.1"
  description "Art of Song Stations Directory Extension."
  url "http://www.hellovenado.com"

  define_routes do |map|
    map.resources :organizations
  end
  
  def activate
    # Radiant::Config['directory.google_map_key'] = "ABQIAAAAKsmqeCs1JL6iKytv5zPbWRRxyiqsqZP386g7oAfXqfyEEC3E9hR3qqnQIloM6XhKCwZc2RyvblZH1g"
    admin.tabs.add "Stations", "/organizations", :after => "Pages", :visibility => [:all]
    DirectoryTags
  end
  
  def deactivate
    # Radiant::Config['directory.google_map_key'] = nil
    admin.tabs.remove "Directory"
  end
    
end