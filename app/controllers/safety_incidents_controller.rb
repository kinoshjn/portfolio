class SafetyIncidentsController < ApplicationController
  def index
    @safety_incidents = Safety_incident.includes(:flight_record)
  end
end
