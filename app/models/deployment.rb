class Deployment < ActiveRecord::Base

  validates :name, presence: true , allow_blank: false

  has_many :permissions
  has_many :environments
  has_many :users, through: :permissions

end
