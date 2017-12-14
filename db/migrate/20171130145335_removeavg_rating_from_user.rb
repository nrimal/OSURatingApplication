class RemoveavgRatingFromUser < ActiveRecord::Migration
  def change
      remove_column :Users, :avgRating
      remove_column :Users, :numberOfPosts
  end
end
