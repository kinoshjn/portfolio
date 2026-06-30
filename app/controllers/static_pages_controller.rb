class StaticPagesController < ApplicationController
  def aircraft_list_index
    #   @aircrafts = Aircraft.includes(:user)
    @aircrafts = [ current_user.aircraft ].compact
  end

  def aircraft_show
    @aircrafts =  Aircraft.find(params[:id])
  end

  def aircraft_new
    if current_user.aircraft.present?
      flash.now[:danger] = "複数機体は登録できません。(サイドメニュー押すと戻ります)"
      @aircrafts = [ current_user.aircraft ].compact
      render "static_pages/aircraft_list_index", status: :ok
      return
    end
    @aircraft = current_user.build_aircraft
  end

  def aircraft_edit
    @aircraft = current_user.aircraft
    render "static_pages/aircraft_edit"
  end

  def aircraft_update
    @aircraft = current_user.aircraft
    if @aircraft.update(aircraft_params)
      render "static_pages/aircraft_show", status: :ok
    else
      flash.now[:danger] = @aircraft.errors.full_messages.join("、")
      render "static_pages/aircraft_edit", status: :unprocessable_entity
    end
  end

  def flight_log_index
    @aircrafts = [ current_user.aircraft ].compact
    @flight_logs = current_user.aircraft.present? ? current_user.aircraft.flight_logs : []
  end

  def flight_log_show
    @aircrafts = [ current_user.aircraft ].compact   # view側アソシエーション対応とした。box2 renderで必要。2026.6/24
    @flight_log = FlightLog.find(params[:id])
  end

  def flight_log_new
  end

  def flight_log_edit
  end

  def daily_inspection_index
    @aircrafts = [ current_user.aircraft ].compact
    @daily_inspections = current_user.aircraft.present? ? current_user.aircraft.daily_inspections : []
  end

  def daily_inspection_new
  end

  def daily_inspection_edit
  end

  def inspection_maintenance_index
    @aircrafts = [ current_user.aircraft ].compact
    @inspection_maintenances = current_user.aircraft.present? ? current_user.aircraft.inspection_maintenance : nil
  end

  def inspection_maintenance_show
    @aircrafts = [ current_user.aircraft ].compact
    @inspection_maintenance = InspectionMaintenance.find(params[:id])
  end

  def inspection_maintenance_new
  end

  def inspection_maintenance_edit
  end

  def delete_confirm_index
    render layout: "minimal"
  end

  def aircraft_destroy
    @aircraft = current_user.aircraft
    @aircraft.destroy
    render html: "<script>window.opener.location.reload(); window.close();</script>".html_safe, layout: false
  end

  private

  def aircraft_params
    params.require(:aircraft).permit(
      :dips_registration_number, :dips_type, :dips_model, :dips_model_other,
      :dips_type_approval_number, :dips_type_approval_number_other,
      :dips_aircraft_registration_category, :dips_aircraft_registration_category_other,
      :dips_designer_and_manufacturer, :dips_serial_number,
      :owner_manufacturer, :model_purchased, :owner_date_purchased, :owner_name,
      :remote_id_registration_number, :owner_insurance_company, :owner_policy_number,
      :owner_insurance_start_date, :owner_insurance_expiration_date
    )
  end
end
