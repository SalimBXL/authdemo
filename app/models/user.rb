class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def full_name
    firstname.present? ? "#{firstname} #{lastname}" : email_address.split('@').first
  end

  def user_name
    firstname.present? ? firstname : email_address.split('@').first
  end
end
