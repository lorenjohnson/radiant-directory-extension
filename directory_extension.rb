class DirectoryExtension < Radiant::Extension
  version "1.0"
  description "Radiant Organization Directory Extension."
  url "http://www.fn-group.com"

  define_routes do |map|
    map.resources :directory_orgs, :path_prefix => "/admin"
  end
  
  def activate
    admin.tabs.add "Church Directory", "/admin/directory_orgs", :after => "Layouts", :visibility => [:all]
    DirectoryTags
  end
  
  def deactivate
    admin.tabs.remove "Church Directory"
  end
    
end