class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :tasks, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?

  def full_name
    (firstname.present? and lastname.present?) ? "#{firstname} #{lastname}" : email_first_part
  end

  def user_name
    firstname.present? ? firstname : email_first_part
  end

  # Retourne la liste des tâches associées à l'utilisateur courant
  def tasks_for_current_user
    tasks.includes(:project).order(due_date: :asc)
  end

  private

  def password_required?
    new_record? || password.present?
  end

  def email_first_part
    email_address.split("@").first
  end
end
