class Item < ActiveRecord::Base
  belongs_to :user
  has_many :requests
  
  validates_presence_of :user
  acts_as_mappable :through => :user
  
  def self.search(string, user)
    
    find(:all, :limit => 30,
      :conditions => ["items.title rlike :search OR items.description rlike :search",
        {:search => string}]) || []
  end
    
  
  def to_s() title end
end
