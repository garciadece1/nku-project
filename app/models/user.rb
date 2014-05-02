class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9_\.-]{1,}@[a-zA-Z0-9_\.-]{1,}\.[a-zA-Z0-9_-]{2,}\z/, message: "Invalid email format" }
  validates :name, presence: true, length: { minimum: 2 }

  before_save { |user| user.email = email.downcase }
  before_save :generate_verification_email
  before_save :create_remember_token

  has_secure_password
  has_many :documents, dependent: :destroy
  has_one :verification, dependent: :destroy

  private
  def generate_verification_email
    if (not @sent) && (((not self.verified?) && self.completed?) || (self.email_changed? && self.id))
      @sent = true
      return Verification.create(user: self)
    end
  end

   def create_remember_token
    if self.remember_token.nil? || self.remember_token.empty?
      self.remember_token = SecureRandom.urlsafe_base64
    end
  end
end
