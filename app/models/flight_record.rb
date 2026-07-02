class FlightRecord < ApplicationRecord
  belongs_to :flight_log
  has_one :safety_incident, dependent: :destroy
  accepts_nested_attributes_for :safety_incident, reject_if: :all_blank

  validates :pilot_name, presence: true
  validates :takeoff_time, presence: true
  validates :landing_time, presence: true
  validates :takeoff_location, presence: true
  validates :landing_location, presence: true
  validates :flight_summary, presence: true
  validates :has_safety_incident, inclusion: { in: [ true, false ] }

  validate :landing_after_takeoff

  private

  def landing_after_takeoff
    return unless takeoff_time.present? && landing_time.present?
    if landing_time <= takeoff_time
      errors.add(:landing_time, "は離陸時刻より後の時刻を入力してください")
    end
  end
end
