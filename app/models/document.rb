  class Document < ActiveRecord::Base
  belongs_to :user
  attr_accessor :pending_file  # this defines a `pending_file` and `pending_file=` method.
  after_save :write_pending_file
  before_create :generate_key

  def self.import(file, email)
    # This is an idiomatic way to implement a "guard".
    return false unless file

    params = {
      name: file.original_filename,
      size: file.size, 
      content_type: file.content_type, 
      pending_file: file
    }

    if email && (not email.empty?)
      user = User.find_by_email(email)
      if user.nil?
        params['user'] = User.create(name: "temporary", email: email, password: email, password_confirmation: email, completed: false, verified: false)
      else
        params['user'] = user
      end
    end
    Document.create(params)
  end
  
  def file_src
    Rails.configuration.public_file_path + file_name
  end

  def file_name
    read_attribute(:id).to_s << "-" << read_attribute(:name)
  end

  def write_file(file)
    file_src = File.join(Rails.configuration.public_file_path, file_name)
    File.open(file_src, "wb") { |f| f.write(file.read) }
  end

  def write_pending_file
    pending_file ? write_file(pending_file) : true
  end

  def generate_key
    size = 2
    begin
      self.key = SecureRandom.hex(size)
      size = size * 2
    end while self.class.exists?(:key => key)
  end

end
