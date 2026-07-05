class InspectionMaintenanceItem < ApplicationRecord
  belongs_to :inspection_maintenance
  #  has_many :inspection_maintenance_item, dependent: :destroy

  validates :item_date,  presence: true
  validates :item_maintenance_details,  presence: true
  validates :item_reson_implementation, presence: true
  validates :item_location,  presence: true
  validates :item_organizer, presence: true
end
