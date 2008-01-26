class DirectoryExtension < Radiant::Extension
  version "0.1"
  description "Art of Song Stations Directory Extension."
  url "http://www.hellovenado.com"

  define_routes do |map|
    map.resources :organizations
  end
  
  def activate
    # Radiant::Config['directory.google_map_key'] = "ABQIAAAAKsmqeCs1JL6iKytv5zPbWRRkAWczaLFjKT11Xwc79OTdW8lxTRQj-CVbOBChwHcHX51DsffpGXAr4w"
    admin.tabs.add "Directory", "/organizations", :after => "Layouts", :visibility => [:all]
    DirectoryTags
  end
  
  def deactivate
    # Radiant::Config['directory.google_map_key'] = nil
    admin.tabs.remove "Directory"
  end
    
end