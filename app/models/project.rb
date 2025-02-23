class Project < ActiveRecord::Base
  has_many :tasks
  belongs_to :user

  validates :name, presence: true
  validates :description, presence: true
  validates :user_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end