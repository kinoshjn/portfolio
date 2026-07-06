class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :logged_in?, :current_user

  # 2026.6/23     入れるとエラー
  #  before_action :require_login

  def logged_in?
    !!current_user
  end

  def logout
    session[:user_id] = nil
    @current_user = nil
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # 2026.6/19 フラッシュメッセージの追加
  add_flash_types :success, :danger

  private

  def require_login
    redirect_to login_path unless logged_in?
  end

  #  def calculate_total_flight_time(item_date)
  #    total = 0
  #    current_user.aircraft.flight_logs.where("flight_date <= ?", item_date).each do |flight_log|
  #      last_record = flight_log.flight_records.order(:id).last
  #      total += last_record&.total_flight_time.to_i
  #    end
  #    total
  #  end

  def calculate_total_flight_time(item_date)
    total = 0
    current_user.aircraft.flight_logs.where("flight_date <= ?", item_date).includes(:flight_records).each do |flight_log|
      total += flight_log.flight_records.sum(&:flight_time)
    end
    total
  end
end
