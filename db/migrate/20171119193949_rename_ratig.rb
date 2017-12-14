class RenameRatig < ActiveRecord::Migration
  def change
      rename_column :rooms, :avgRatig, :avgRating
  end
end
