class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy # Supprime les tâches associées lorsque le projet est supprimé
  belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :user_id, presence: true

  # Retourne la liste des utilisateurs associés aux tâches du projet
  def users
    User.joins(:tasks).where(tasks: { project_id: id }).distinct
  end

  def tasks_count
    tasks.count
  end

end
