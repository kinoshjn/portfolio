class FlightRecordsController < ApplicationController
  def index
    @flight_records = Flight_record.includes(:flight_log)
  end
end
