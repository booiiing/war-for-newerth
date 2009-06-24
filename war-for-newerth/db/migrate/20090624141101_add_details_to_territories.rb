class AddDetailsToTerritories < ActiveRecord::Migration
  def self.up
    add_column :territories, :details, :text
  end

  def self.down
    remove_column :territories, :details
  end
end
