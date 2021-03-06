class CreateNews < ActiveRecord::Migration
  def self.up
    create_table :news do |t|
      t.integer :poster_id
      t.string :title
      t.text :text

      t.timestamps
    end
  end

  def self.down
    drop_table :news
  end
end
