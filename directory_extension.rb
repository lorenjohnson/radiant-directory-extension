class DirectoryExtension < Radiant::Extension
  version "1.0"
  description "Radiant Organization Directory Extension."
  url "http://www.fn-group.com"

  define_routes do |map|
    map.resources :directory_orgs, :path_prefix => "/admin"
  end
  
  def activate
    Radiant::Config['directory.google_map_key'] = "xxxx"
    admin.tabs.add "Directory", "/admin/directory_orgs", :after => "Layouts", :visibility => [:all]
    DirectoryTags
  end
  
  def deactivate
    Radiant::Config['directory.google_map_key'] = nil
    admin.tabs.remove "Directory"
  end
    
end