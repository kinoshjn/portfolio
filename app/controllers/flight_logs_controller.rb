class FlightLogsController < ApplicationController
  def index
    @flight_logs = Flight_log.includes(:aircraft)
  end
end
