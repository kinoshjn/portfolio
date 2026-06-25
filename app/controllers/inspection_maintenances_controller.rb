class InspectionMaintenancesController < ApplicationController
  before_action :require_login

  def index
    #   @inspection_maintenances = Inspection_maintenance.includes(:aircraft)
    render "static_pages/inspection_maintenance_index"
  end
end
