class AddBuildingIdColumnsToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :building_id, :integer
  end
end
