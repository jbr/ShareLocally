class Item < ActiveRecord::Base
  belongs_to :user
  has_many :requests, :dependent => :destroy
  
  validates_presence_of :user
  acts_as_mappable :through => :user
  
  def self.search(string, user)
    find(:all, :origin => user, :order => "distance", :limit => 30, :within => 50,
      :conditions => ["(items.title rlike :search OR items.description rlike :search) AND items.user_id <> :user_id",
        {:search => string, :user_id => user.id}])
    rescue
      []
  end
    
  
  def to_s() title end
end
