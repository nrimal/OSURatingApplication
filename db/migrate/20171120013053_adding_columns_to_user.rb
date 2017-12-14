class AddingColumnsToUser < ActiveRecord::Migration
  def change
      add_column :users, :avgRating, :float
      add_column :users, :numberOfPosts, :integer
  end
end
