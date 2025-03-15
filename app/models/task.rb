class Task < ApplicationRecord
  enum :status, {
    new: 0,
    in_progress: 1,
    done: 2,
    delayed: 3
  }, prefix: :status

  enum :level, {
    low: 0,
    medium: 1,
    high: 2
  }, prefix: :level

  belongs_to :project
  belongs_to :user

  validates :name, presence: true
  validates :project_id, presence: true
  validates :user_id, presence: true
  validates :status, presence: true
  validates :level, presence: true
  validates :start_date, presence: true
  validates :due_date, presence: true
  validate :due_date_after_start_date

  # Vérifie que la date d'échéance est postérieure ou égale à la date de début
  def due_date_after_start_date
    if due_date.present? && start_date.present? && due_date < start_date
      errors.add(:due_date, "must be after or equal to the start date")
    end
    due_date >= start_date
  end

  # Vérifie si la tâche est en retard
  def overdue?
    due_date.present? && due_date < Date.today && !status_done?
  end

  def self.high_level_count  # Retourne le nombre de tâches avec le niveau "high"  validates :due_date, presence: true  validates :start_date, presence: true  validates :level, presence: true  validates :status, presence: true  validates :user_id, presence: true  validates :project_id, presence: true  validates :name, presence: true  enum status: { new: 0, in_progress: 1, completed: 2 }  enum level: { low: 0, medium: 1, high: 2 }  belongs_to :user  belongs_to :project  # Définition correcte des enums avec des clés et valeurs valides
    where(level: :high).count
  end

  def self.medium_level_count  # Retourne le nombre de tâches avec le niveau "medium"  validates :due_date, presence: true  validates :start_date, presence: true  validates :level, presence: true  validates :status, presence: true  validates :user_id, presence: true  validates :project_id, presence: true  validates :name, presence: true  enum status: { new: 0, in_progress: 1, completed: 2 }  enum level: { low: 0, medium: 1, high: 2 }  belongs_to :user  belongs_to :project  # Définition correcte des enums avec des clés et valeurs valides
    where(level: :medium).count
  end

  def self.low_level_count  # Retourne le nombre de tâches avec le niveau "low"  validates :due_date, presence: true  validates :start_date, presence: true  validates :level, presence: true  validates :status, presence: true  validates :user_id, presence: true  validates :project_id, presence: true  validates :name, presence: true  enum status: { new: 0, in_progress: 1, completed: 2 }  enum level: { low: 0, medium: 1, high: 2 }  belongs_to :user  belongs_to :project  # Définition correcte des enums avec des clés et valeurs valides
    where(level: :low).count
  end

  # Retourne le nombre de jours avant la date d'échéance ou 0 si la tâche est en retard
  def how_many_days_before_due_date?
    days_left = (due_date - Date.today).to_i
    (due_date_after_start_date and not overdue?) ? days_left : 0
  end
end
