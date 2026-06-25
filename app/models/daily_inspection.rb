class DailyInspection < ApplicationRecord
  belongs_to :aircraft
  has_many :daily_inspection_items, dependent: :destroy
end
