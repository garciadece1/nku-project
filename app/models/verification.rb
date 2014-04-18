class Verification < ActiveRecord::Base
  belongs_to :user

  before_create :generate_key
  after_create :send_email

  def verify
    self.user.update(verified: true)
    self.destroy
  end

  private
    # Generate a key randomly
    def generate_key
      size = 4
      begin
        self.key = SecureRandom.hex(size)
        size = size * 2
      end while self.class.exists?(:key => key)
    end

    # send the email
    def send_email
      ModelMailer.request_email_verification(self).deliver
    end
end
