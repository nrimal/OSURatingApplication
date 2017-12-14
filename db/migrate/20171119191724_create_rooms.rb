class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :roomNum
      t.float :avgRatig

      t.timestamps null: false
    end
  end
end
