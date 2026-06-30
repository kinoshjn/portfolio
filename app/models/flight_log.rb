class FlightLog < ApplicationRecord
  belongs_to :aircraft
  has_many :flight_records, dependent: :destroy

  accepts_nested_attributes_for :flight_records   # update時子供も一緒に更新させるため
end
