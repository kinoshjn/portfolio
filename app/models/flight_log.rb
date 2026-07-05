class FlightLog < ApplicationRecord
  belongs_to :aircraft
  has_many :flight_records, dependent: :destroy
  accepts_nested_attributes_for :flight_records
  validates :flight_date, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "aircraft_id", "created_at", "flight_date", "id", "updated_at" ]
  end
end
