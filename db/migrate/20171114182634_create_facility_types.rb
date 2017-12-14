class CreateFacilityTypes < ActiveRecord::Migration
  def change
    create_table :facility_types do |t|
      t.text :type

      t.timestamps null: false
    end
  end
end
