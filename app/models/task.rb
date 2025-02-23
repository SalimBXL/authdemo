class Task < ApplicationRecord
    belongs_to :level
    belongs_to :user
    belongs_to :project

    validates :name, presence: true
    validates :description, presence: true
end
