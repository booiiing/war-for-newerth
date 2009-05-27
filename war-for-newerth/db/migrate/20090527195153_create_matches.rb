class CreateMatches < ActiveRecord::Migration
  def self.up
    create_table :matches do |t|
      t.datetime :schedule
      t.integer :attacker_id
      t.integer :defender_id
      t.integer :winner_id

      t.timestamps
    end

    create_table :users_matches do |t|
      t.integer :match_id
      t.integer :user_id
    end
  end

  def self.down
    drop_table :matches
  end
end
