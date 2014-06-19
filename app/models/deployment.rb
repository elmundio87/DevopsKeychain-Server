class Deployment < ActiveRecord::Base

  validates :name, presence: true , allow_blank: false

  has_many :permissions, dependent: :destroy
  has_many :environments, dependent: :destroy
  has_many :users, through: :permissions

end
