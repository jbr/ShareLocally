class AddNotificationPendingToRequests < ActiveRecord::Migration
  def self.up
    add_column :requests, :notification_pending, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :requests, :notification_pending
  end
end
