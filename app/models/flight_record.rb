class FlightRecord < ApplicationRecord
  before_save :calculate_times

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

  def calculate_times
    return unless takeoff_time.present? && landing_time.present?

    # 今回の飛行時間（分）
    self.flight_time = ((landing_time - takeoff_time) / 60).to_i

    # 同じFlightLog内の最後のFlightRecordを取得（自分はまだ保存されていない）
    last_record = flight_log.flight_records.order(:created_at).last

    # 前回までの累積飛行時間
    prev_total = last_record&.total_flight_time.to_i

    # 累積飛行時間
    self.total_flight_time = prev_total + flight_time
  end
end
