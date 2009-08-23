class Request < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :item
  belongs_to :user
  
  named_scope :for, lambda { |item|
    {:conditions => {:item_id => item.id}}
  }
  
  validates_uniqueness_of :item_id, :scope => :user_id
end
