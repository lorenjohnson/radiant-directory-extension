module Import
  def execute
    NhMember.find(:all).each do |m|
      nm = DirectoryOrg.new
      nm.name = m.name
      nm.category = n.category
      nm.website_url = n.site
      nm.phone = m.phone
      nm.address_line1 = m.address
      nm.address_city = "Portland"
      nm.address_state = "OR"
      nm.address_zip = "97209"
  end

  class NhMember < ActiveRecord::Base
    establish_connection "import"
    
  end
end