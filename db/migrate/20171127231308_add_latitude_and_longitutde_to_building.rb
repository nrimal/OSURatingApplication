class AddLatitudeAndLongitutdeToBuilding < ActiveRecord::Migration
  def change
      add_column :buildings, :longitude, :integer
      add_column :buildings, :latitude, :integer
  end
end
