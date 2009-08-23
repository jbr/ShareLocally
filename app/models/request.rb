class Request < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :item
  belongs_to :user
  
  validates_uniqueness_of :item_id, :scope => :user_id
end
