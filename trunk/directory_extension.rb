class DirectoryExtension < Radiant::Extension
  version "1.0"
  description "Radiant Organization Directory Extension."
  url "http://www.fn-group.com"

  define_routes do |map|
    map.resources :directory_orgs
    map.resources :configuration
  end
  
  def activate
    # Radiant::Config['directory.google_map_key'] = "ABQIAAAAKsmqeCs1JL6iKytv5zPbWRRkAWczaLFjKT11Xwc79OTdW8lxTRQj-CVbOBChwHcHX51DsffpGXAr4w"
    admin.tabs.add "Directory", "/directory_orgs", :after => "Layouts", :visibility => [:all]
    DirectoryTags
  end
  
  def deactivate
    # Radiant::Config['directory.google_map_key'] = nil
    admin.tabs.remove "Directory"
  end
    
end