class AddUrlParamToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :url_param, :string
  end

  def self.down
    remove_column :users, :url_param
  end
end
