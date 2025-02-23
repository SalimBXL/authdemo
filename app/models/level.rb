class Level < ApplicationRecord
    has_many :tasks, dependent: :destroy

    validates :level, presence: true
end
