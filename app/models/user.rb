class User < ActiveRecord::Base
  validates :email, uniqueness: true, presence: true, format: {with: /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/ message:"Invalid email format"}
  validates :password, presence: true, length: {in: 6..10, message:"Must be 6 to 10 characters"}

  def password
    Password.new(self.password_hash)
  end

  def password=(new_password)
    self.password_hash = Password.create(new_password)
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    user if user.password == password
  end
end
