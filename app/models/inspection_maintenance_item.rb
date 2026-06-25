class InspectionMaintenanceItem < ApplicationRecord
  belongs_to :inspection_maintenance
  has_many :inspection_maintenance_item, dependent: :destroy
end
