class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :poster_id
      t.integer :new_id
      t.text :text

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
