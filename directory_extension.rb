class DirectoryExtension < Radiant::Extension
  version "1.0"
  description "Radiant Directory Extension."
  url "http://www.diotribe.net"

  define_routes do |map|
    # map.connect 'admin/church_finder/:action', :controller => 'admin/asset'
    # map.connect 'directory/:nameSearch', :controller => 'site', :action => 'show_page', :url => 'directory'
  end
  
  def activate
    # admin.tabs.add "Church Finder", "/admin/church_finder", :after => "Layouts", :visibility => [:all]
    DirectoryTags
  end
  
  def deactivate
    # admin.tabs.remove "Church Finder"
  end
    
end