class Environment < ActiveRecord::Base

  validates :name, presence: true , allow_blank: false
  validates :deployment, presence: true , allow_blank: false
end
