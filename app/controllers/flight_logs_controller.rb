class FlightLogsController < ApplicationController
  before_action :require_login

  def index
    #   @flight_logs = Flight_log.includes(:aircraft)
    #    @flight_logs = current_user.aircraft.flight_logs
    #    @aircrafts = [current_user.aircraft].compact  # ← 機体選択用について
    render "static_pages/flight_log_index"
  end

  def show
    @flight_log =FlightLog.find(params[:id])
    render "static_pages/flight_log_show"
  end
end
