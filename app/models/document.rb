class Document < ActiveRecord::Base
  belongs_to :user

  def file_name
    read_attribute(:id).to_s << "-" << read_attribute(:name)
  end

  def file_src
    Rails.configuration.public_file_path + file_name
  end

  def self.import(file)
    if file.nil?
      nil
    else
      doc = Document.new(name: file.original_filename, size: file.size, content_type: file.content_type)
      if doc.save
        path = File.join(Rails.configuration.public_file_path, doc.file_name)
        if (File.open(path, "wb") { |f| f.write(file.read) })
          doc
        else
          doc.delete
          nil
        end
      else
        nil
      end
    end
  end
end
