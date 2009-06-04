class AddPositionToTerritories < ActiveRecord::Migration
  def self.up
    add_column :territories, :position_x, :float
    add_column :territories, :position_y, :float
  end

  def self.down
    remove_column :territories, :position_x
    remove_column :territories, :position_y
  end
end
