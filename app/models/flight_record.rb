class FlightRecord < ApplicationRecord
  belongs_to :flight_log
  has_one :safety_incident, dependent: :destroy
end
