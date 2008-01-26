class CreateDirectoryOrgs < ActiveRecord::Migration
  def self.up
    create_table :organizations do |t|
      t.column :name, :string
      t.column :address_line1, :string
      t.column :address_line2, :string
      t.column :address_city, :string
      t.column :address_state, :string
      t.column :address_zip, :string
      t.column :phone, :string
      t.column :fax, :string
      t.column :website_url, :string
      t.column :lat, :string
      t.column :lng, :string
      t.column :ignore_address, :boolean
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end
  
  def self.down
    drop_table :organizations
  end
end