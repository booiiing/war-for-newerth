class CreateTerritories < ActiveRecord::Migration
  def self.up
    create_table :territories do |t|
      t.string :name
      t.string :map_name
      t.string :shape
      t.integer :clan_id

      t.timestamps
    end
  end

  def self.down
    drop_table :territories
  end
end
