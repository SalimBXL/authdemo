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
  validates :start_date, presence: true
  validates :due_date, presence: true
  validates :criticity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validate :due_date_after_start_date

  before_save :set_level_from_criticity

  # Vérifie que la date d'échéance est postérieure ou égale à la date de début début
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

  def self.high_level_count  # Retourne le nombre de tâches avec le niveau "high"
    where(level: :high, status: !:done).count
  end

  def self.medium_level_count  # Retourne le nombre de tâches avec le niveau "medium"
    where(level: :medium, status: !:done).count
  end

  def self.low_level_count  # Retourne le nombre de tâches avec le niveau "low"
    where(level: :low, status: !:done).count
  end

  def self.new_status_count  # Retourne le nombre de tâches avec le status "new"
    where(status: :new).count
  end
  
  def self.in_progress_status_count  # Retourne le nombre de tâches avec le status "in_progress"
    where(status: :in_progress).count
  end

  def self.done_status_count  # Retourne le nombre de tâches avec le status "done"
    where(status: :done).count
  end

  # Retourne le nombre de jours avant la date d'échéance ou 0 si la tâche est en retard
  def how_many_days_before_due_date?
    days_left = (due_date - Date.today).to_i
    (due_date_after_start_date and not overdue? and not :done) ? days_left : 0
  end

  def priority
    days = how_many_days_before_due_date? > 0 ? how_many_days_before_due_date? : 1
    0.5 * criticity / days
  end

  def set_level_from_criticity
    self.level = case self.criticity
                  when 0..3 then :low
                  when 4..6 then :medium
                  when 7..10 then :high
                  else :low
                  end
  end

end
