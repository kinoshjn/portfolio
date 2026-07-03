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

  def create
    if current_user.aircraft.inspection_maintenance.present?
      flash.now[:danger] = "既に点検整備記録が登録されています。編集画面をご利用ください。(サイドメニュー押すと戻ります)"
      @aircrafts = [ current_user.aircraft ].compact
      @inspection_maintenances = current_user.aircraft.inspection_maintenance
        render "static_pages/inspection_maintenance_index", status: :ok
      return
    end
    @inspection_maintenance = current_user.aircraft.build_inspection_maintenance(inspection_maintenance_params)
    if @inspection_maintenance.save
      render "static_pages/inspection_maintenance_show", status: :ok
    else
      render "static_pages/inspection_maintenance_new", status: :unprocessable_entity
    end
  end

  private

  def inspection_maintenance_params
    params.require(:inspection_maintenance).permit(
      :special_notes, :aircraft_id,
      inspection_maintenance_items_attributes: [
        :item_date, :item_total_flight_time,
        :item_maintenance_details, :item_reson_implementation,
        :item_location, :item_organizer, :item_note
      ]
    )
  end

end
