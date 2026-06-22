class InspectionMaintenancesController < ApplicationController
  def index
    @inspection_maintenances = Inspection_maintenance.includes(:aircraft)
  end
end
