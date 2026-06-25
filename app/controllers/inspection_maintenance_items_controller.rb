class InspectionMaintenanceItemsController < ApplicationController
  def index
    @inspection_maintenance_items = Inspection_maintenance_item.includes(:inspection_maintenance)
  end
end
