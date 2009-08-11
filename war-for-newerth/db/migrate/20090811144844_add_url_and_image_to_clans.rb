class AddUrlAndImageToClans < ActiveRecord::Migration
  def self.up
    add_column :clans, :official_url, :string
    add_column :clans, :sencondary_url, :string
  end

  def self.down
    remove_column :clans, :official_url
    remove_column :clans, :sencondary_url
  end
end
