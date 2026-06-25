class FlightLog < ApplicationRecord
  belongs_to :aircraft

  has_many :flight_records, dependent: :destroy
end
