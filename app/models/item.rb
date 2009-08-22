class Item < ActiveRecord::Base
  belongs_to :user
  has_many :requests
  
  validates_presence_of :user
  acts_as_mappable :through => :user
  
  def to_s() title end
end
