class Project < ApplicationRecord
  has_many :tasks
  belongs_to :user

  validates :name, presence: true
  validates :description, presence: true
  validates :user_id, presence: true
end
