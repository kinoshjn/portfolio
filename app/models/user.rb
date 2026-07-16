class User < ApplicationRecord
  has_secure_password

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:password_digest] }
  validates :email, presence: true, uniqueness: true
  validates :user_name, presence: true

  # 2026.7/16追記 パスワードリセット機能追加
  validates :reset_password_token, uniqueness: true, allow_nil: true

  has_one :aircraft, dependent: :destroy

  # ユーザログイン数計測用  2026.6/26修正
  def record_login!
    return if last_login_date == Date.today
    update!(
      login_count: login_count.to_i + 1,
      last_login_date: Date.today
    )
  end

  # 2026.7/16追記 パスワードリセット機能
  def generate_reset_password_token!
    reset_password_token = SecureRandom.hex(16)
    while User.exists?(reset_password_token:)
      reset_password_token = SecureRandom.hex(16)
    end
    self.reset_password_token = reset_password_token
    update!(reset_password_token_expires_at: 1.hour.from_now)
  end

  # ユーザログイン数によって画像変更 2026.6/27追記
  def avatar_icon_path
    case login_count
    when  0     then  "avatars/avatar_LV0.png"
    when  1     then  "avatars/avatar_LV1.png"
    when  2     then  "avatars/avatar_LV2.png"
    when  3     then  "avatars/avatar_LV3.png"
    when  4     then  "avatars/avatar_LV4.png"
    when  5     then  "avatars/avatar_LV5.png"
    when  6     then  "avatars/avatar_LV6.png"
    when  7     then  "avatars/avatar_LV7.png"
    when  8     then  "avatars/avatar_LV8.png"
    else              "avatars/avatar_LV9.png"
    end
  end
end
