class SecureContent < ActiveRecord::Base

  attr_encrypted :content

  validates :encrypted_content, :symmetric_encryption => true

  belongs_to :environment

end
