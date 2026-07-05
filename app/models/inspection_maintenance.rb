class InspectionMaintenance < ApplicationRecord
  belongs_to :aircraft
  has_many :inspection_maintenance_items, dependent: :destroy
  accepts_nested_attributes_for :inspection_maintenance_items
end
