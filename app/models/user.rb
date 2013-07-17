class User < ActiveRecord::Base
  attr_accessor :raw_password
  attr_accessor :raw_password_confirmation
  validates :email, uniqueness: true, presence: true, format: {with: /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/, message: "Invalid email format"}
  validates :raw_password, presence: true, length: { in: 6..10, too_short:"Must be 6 to 12 characters"}
  validates_confirmation_of :raw_password, message: 'passwords should match'
  before_save :generate_hash
  
  def generate_hash
    self.password_hash = BCrypt::Password.create(self.raw_password)
  end

  def password
    BCrypt::Password.new(self.password_hash)
  end

  def password=(new_password)
    self.password_hash = BCrypt::Password.create(new_password)
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    if user && user.password == password
      user
    else
      nil
    end
  end
end
