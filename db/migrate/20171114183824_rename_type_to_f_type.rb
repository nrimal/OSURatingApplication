class RenameTypeToFType < ActiveRecord::Migration
  def change
      rename_column :facility_types, :type, :ftype
  end
end
