class AddReceivesRequestNotificationsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :receives_request_notifications, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :users, :receives_request_notifications
  end
end
