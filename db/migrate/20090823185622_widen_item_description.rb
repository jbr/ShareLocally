class WidenItemDescription < ActiveRecord::Migration
  def self.up
    change_column :items, :description, :string, :limit => 2048
  end

  def self.down
    change_column :items, :description, :string, :limit => 256
  end
end
