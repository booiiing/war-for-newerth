class AddColorsAndImagesToClans < ActiveRecord::Migration
  def self.up
    add_column :clans, :color, :string
    add_column :clans, :image, :binary
  end

  def self.down
    remove_column :clans, :color
    remove_column :clans, :image
  end
end
