class UpdateDirectoryForAotsReqs
  def self.up
    add_column :organizations, :dial, :string
    add_column :organizations, :air_time, :string
    add_column :organizations, :web_stream, :string
  end

  def self.down
    remove_column :organizations, :dial
    remove_column :organizations, :air_time
    remove_column :organizations, :web_stream
  end
end