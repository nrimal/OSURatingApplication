class ChangeLongLatTypes < ActiveRecord::Migration
  def change
      change_column :buildings, :longitude, :float
      change_column :buildings, :latitude, :float
  end
end
