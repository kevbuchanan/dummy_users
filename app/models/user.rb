class User < ActiveRecord::Base
  has_many :urls
  
  attr_accessor :password
  attr_accessor :password_confirmation
  validates :email, uniqueness: true, presence: true, format: {with: /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/, message: "Invalid email format"}
  validates :password, presence: true#, length: { in: 6..12, too_short:"must be 6 to 12 characters", too_long: "must be 6 to 12 characters"}
  before_save :hash_password
  validates_confirmation_of :password

  def hash_password
    self.password_hash = BCrypt::Password.create(self.password)
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    if user && BCrypt::Password.new(user.password_hash) == password
      user
    else
      nil
    end
  end
end
