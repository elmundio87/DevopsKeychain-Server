class Environment < ActiveRecord::Base

  validates :name, presence: true , allow_blank: false
  validates :deployment_id, presence: true , allow_blank: false

  belongs_to :deployment
  has_many :secure_content

end
