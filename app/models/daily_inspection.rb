class DailyInspection < ApplicationRecord
  validates :inspection_date, presence: true
  validates :inspection_location, presence: true
  validates :inspector, presence: true

  belongs_to :aircraft
  has_many :daily_inspection_items, dependent: :destroy
  accepts_nested_attributes_for :daily_inspection_items

  def self.ransackable_attributes(auth_object = nil)
    [ "aircraft_id", "created_at", "inspection_date", "id", "updated_at" ]
  end
end
