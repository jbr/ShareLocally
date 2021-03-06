class Request < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :item
  belongs_to :user
  
  validates_uniqueness_of :item_id, :scope => :user_id
  validate :user_cannot_be_owner
  
  def user_cannot_be_owner
    errors.add(:user, "cannot be owner") if item.user == user
  end
end
