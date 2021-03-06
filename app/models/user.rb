require 'digest/sha1'

class User < ActiveRecord::Base
  generate_url_param_from :login
  acts_as_mappable
  before_validation :geocode_address, :if => :address_changed?
  
  has_one :profile
  
  has_many :items
  has_many :incoming_requests, :through => :items, :source => :requests
  
  has_many :outgoing_requests, :class_name => 'Request'
  has_many :requested_items, :through => :outgoing_requests, :source => :item
  
  has_many :incoming_messages, :class_name => 'Message', :foreign_key => :to_user_id
  
  accepts_nested_attributes_for :profile
  attr_accessible :profile_attributes, :phone, :full_name, :address
  
  delegate :about, :to => :profile
  
  
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  include Authorization::AasmRoles

  before_validation :clean_up_phone
  validates_format_of :phone, :with => /\([0-9]{3}\) [0-9]{3}-[0-9]{4}/, :allow_blank => true
    
  validates_presence_of :address

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message
  
  before_create :build_profile

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation
  
  def nearby_items(options = {})
    options.reverse_merge! :origin => self, :order => 'distance', :limit => 10, :within => 50, :conditions => ['user_id <> ?', id]
    Item.find :all, options
  end

  def to_s
    if full_name.blank?
      login
    else
      "#{full_name} (#{login})"
    end
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_in_state :first, :active, :conditions => {:login => login.downcase} # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  def has_access_to_user(user)
    !! user.requested_items.first(:conditions => {:user_id => id})
  end

  protected
    
  def make_activation_code
    self.deleted_at = nil
    self.activation_code = self.class.make_token
  end

  def build_profile
    unless profile
      self.profile = Profile.new
    end
  end
  
  private
  
  def clean_up_phone
    unless phone.blank?
      phone.gsub! /[^0-9]/, ''
      phone.replace "(#{phone.slice(0..2)}) #{phone.slice(3..5)}-#{phone.slice(6..9)}"
    end
  end
  
  def geocode_address
    geo = Geokit::Geocoders::MultiGeocoder.geocode address
    errors.add(:address, "Could not Geocode address") unless geo.success
    self.lat, self.lng = geo.lat,geo.lng if geo.success
    self.address = geo.full_address
  end
end
