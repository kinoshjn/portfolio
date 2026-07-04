class DailyInspectionItem < ApplicationRecord
  validates :item_name, presence: true
  validates :result, presence: true

  belongs_to :daily_inspection
end
