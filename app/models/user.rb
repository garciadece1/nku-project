class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9_\.-]{1,}@[a-zA-Z0-9_\.-]{1,}\.[a-zA-Z0-9_-]{2,}\z/, message: "Invalid email format" }
  before_save { |user| user.email = email.downcase }
  has_secure_password
end
