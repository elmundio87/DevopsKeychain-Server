class SecureContent < ActiveRecord::Base

  attr_encrypted :content

  validates :encrypted_content, :symmetric_encryption => true

end
