class AddEmailColumn < ActiveRecord::Migration
  def self.up
    add_column :directory_orgs, :email, :string
  end

  def self.down
    remove_column :directory_orgs, :email
  end
end
