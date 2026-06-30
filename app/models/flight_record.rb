class FlightRecord < ApplicationRecord
  belongs_to :flight_log
  has_one :safety_incident, dependent: :destroy

  accepts_nested_attributes_for :safety_incident # update時子供も一緒に更新させるため
end
