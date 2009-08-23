class AddAvailableToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :available, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :items, :available
  end
end
