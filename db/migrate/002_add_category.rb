class AddCategory < ActiveRecord::Migration
  def self.up
    add_column :directory_orgs, :category, :string
  end
  
  def self.down
    remove_column :directory_orgs, :category
  end
end