class AddAddressToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :address, :string, :limit => 512
  end

  def self.down
    remove_column :users, :address
  end
end
