class InspectionMaintenance < ApplicationRecord
  belongs_to :aircraft
  has_many :inspection_maintenance_items, dependent: :destroy
end
