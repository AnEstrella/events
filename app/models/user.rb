class User < ActiveRecord::Base
	has_many :comments
	has_many :events, through: :attendees
	has_many :events

  attr_accessor :password

  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

  validates :first_name, :presence => true

  validates :last_name, :presence => true

  validates :email, :presence => true,
            :format => { :with => email_regex },
            :uniqueness => { :case_sensitive => false}

  validates :password, :presence => true,
            :confirmation => true,
            :length => { :within => 8..100}

  #before user gets added to DB, run this function
  before_save :encrypt_password

  #ecrypts the user's unencrypted login attempt and return true if password is a match
  def has_password?(submitted_password)
    self.encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = User.find_by email: (email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  private
  	def encrypt_password
  		# generate a unique salt if it's a new user
  		self.salt = Digest::SHA2.hexdigest("#{Time.now.utc}--#{password}") if self.new_record?
  	
  		# encrypt the password and store that in the encrypted_password field
  		self.encrypted_password = encrypt(password)
  	end

  	# encrypt the password using both the salt and the passed password
  	def encrypt(pass)
  		Digest::SHA2.hexdigest("#{self.salt}--#{pass}")
  	end

end
