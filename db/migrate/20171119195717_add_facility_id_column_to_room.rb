class AddFacilityIdColumnToRoom < ActiveRecord::Migration
  def change
      add_column :rooms, :facilitytype_id, :integer
  end
end
