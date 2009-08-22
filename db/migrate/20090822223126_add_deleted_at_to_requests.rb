class AddDeletedAtToRequests < ActiveRecord::Migration
  def self.up
    add_column :requests, :deleted_at, :datetime
  end

  def self.down
    remove_column :requests, :deleted_at
  end
end
