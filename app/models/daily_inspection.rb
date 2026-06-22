class DailyInspection < ApplicationRecord
  belongs_to :aircraft
  has_many :daily_inspection_item, dependent: :destroy 
end
