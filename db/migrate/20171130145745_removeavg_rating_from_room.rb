class RemoveavgRatingFromRoom < ActiveRecord::Migration
  def change
      remove_column :Rooms, :avgRating
  end
end
