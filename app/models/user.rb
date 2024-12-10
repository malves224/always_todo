class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true, format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\z/ }
  validates :password, presence: true, length: { minimum: 6 }
  validates :name, presence: true
  validates :password_confirmation, presence: true, if: :password_required?
  validates_confirmation_of :password

  def password_required?
    new_record?
  end
end
