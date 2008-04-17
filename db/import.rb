module Import
  def self.execute
    NhMember.find(:all).each do |m|
      nm = DirectoryOrg.new
      nm.name = m["Name"]
      nm.category = m["Catagory"]
      nm.website_url = m["Site"]
      nm.phone = m["Phone"]
      nm.address_line1 = m["Address"]
      nm.address_city = "Portland"
      nm.address_state = "OR"
      nm.address_zip = "97209"
      nm.save
    end
  end

  class NhMember < ActiveRecord::Base
    establish_connection "import" 
  end
end