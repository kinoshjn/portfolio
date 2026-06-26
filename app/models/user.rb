class User < ApplicationRecord
  has_secure_password

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:password_digest] }
  validates :email, presence: true, uniqueness: true
  validates :user_name, presence: true

  has_one :aircraft, dependent: :destroy

  # ユーザログイン数計測用  2026.6/26修正
  def record_login!
    return if last_login_date == Date.today
    update!(
      login_count: login_count.to_i + 1,
      last_login_date: Date.today
    )
  end
end
