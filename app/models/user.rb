class User < ApplicationRecord
  has_secure_password

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:password_digest] }
  validates :email, presence: true, uniqueness: true
  validates :user_name, presence: true
end
