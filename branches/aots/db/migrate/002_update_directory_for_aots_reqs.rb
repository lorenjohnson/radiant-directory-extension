class UpdateDirectoryForAotsReqs < ActiveRecord::Migration
  def self.up
    add_column :organizations, :dial, :string
    add_column :organizations, :airtime, :string
    add_column :organizations, :webstream, :boolean, :default => false
  end

  def self.down
    remove_column :organizations, :dial
    remove_column :organizations, :airtime
    remove_column :organizations, :webstream
  end
end