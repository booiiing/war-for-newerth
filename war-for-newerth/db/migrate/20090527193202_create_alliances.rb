class CreateAlliances < ActiveRecord::Migration
  def self.up
    create_table :alliances do |t|
      t.string :name

      t.timestamps
    end

    create_table :clans_alliances, :id => false do |t|
      t.integer :clan_id
      t.integer :alliance_id
    end
  end

  def self.down
    drop_table :alliances
    drop_table :clans_alliances
  end
end
