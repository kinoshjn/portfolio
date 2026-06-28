class InspectionMaintenancesController < ApplicationController
  before_action :require_login

  def index
    #   @inspection_maintenances = Inspection_maintenance.includes(:aircraft)
    render "static_pages/inspection_maintenance_index"
  end

  def show
    @inspection_maintenance = InspectionMaintenance.find(params[:id])
    render "static_pages/inspection_maintenance_show"
  end
end
