# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class DirectoryExtension < Radiant::Extension
  version "1.0"
  description "Radiant Organization Directory Extension."
  url "http://www.hellovenado.com"

  define_routes do |map|
    map.namespace :admin do |admin|
      admin.resources :organizations
    end
  end
  
  def activate
    admin.tabs.add "Directory", "/admin/organizations", :after => "Layouts", :visibility => [:all]
    DirectoryTags
  end
  
  def deactivate
    admin.tabs.remove "Directory"
  end
    
end