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
    if current_user.aircraft.blank?
      flash.now[:danger] = "先に機体登録してください。(サイドメニュー押すと戻ります)"
      @aircrafts = [ current_user.aircraft ].compact
      render "static_pages/flight_log_index", status: :ok
      return
    end
    @aircrafts = [ current_user.aircraft ].compact
    @flight_log = current_user.aircraft.flight_logs.build
    @flight_log.flight_records.build
  end

  def flight_log_edit
    @aircrafts = [ current_user.aircraft ].compact
    @flight_log = FlightLog.find(params[:id])
    render "static_pages/flight_log_edit"
  end

  def flight_log_update
    @flight_log = FlightLog.find(params[:id])

    flight_log_data = flight_log_params
    flight_log_data[:flight_records_attributes]&.each do |_, record|
      if record[:has_safety_incident] != "true"
        record.delete(:safety_incident_attributes)
      end
    end

    if @flight_log.update(flight_log_data)
      render "static_pages/flight_log_show", status: :ok
    else
      flash.now[:danger] = @flight_log.errors.full_messages.join("、")
      render "static_pages/flight_log_edit", status: :unprocessable_entity
    end
  end

  def flight_log_destroy
    @flight_log = FlightLog.find(params[:id])
    @flight_log.destroy
    render html: "<script>window.opener.location.reload(); window.close();</script>".html_safe, layout: false
  end


  def daily_inspection_index
    @aircrafts = [ current_user.aircraft ].compact
    @daily_inspections = current_user.aircraft.present? ? current_user.aircraft.daily_inspections : []
  end

  def daily_inspection_show
    @aircrafts = [ current_user.aircraft ].compact
    @daily_inspection = DailyInspection.find(params[:id])
  end

  def daily_inspection_new
    if current_user.aircraft.blank?
      flash.now[:danger] = "先に機体登録してください。(サイドメニュー押すと戻ります)"
      @aircrafts = [ current_user.aircraft ].compact
      render "static_pages/daily_inspection_index", status: :ok
      return
    end
    @aircrafts = [ current_user.aircraft ].compact
    @daily_inspection = current_user.aircraft.daily_inspections.build
    [ "機体全般", "プロペラ", "フレーム", "通信系統", "推進系統", "電源系統", "自動制御系統", "操作装置", "バッテリー・燃料" ].each do |name|
    @daily_inspection.daily_inspection_items.build(item_name: name)
    end
  end

  def daily_inspection_edit
    @aircrafts = [ current_user.aircraft ].compact
    @daily_inspection = DailyInspection.find(params[:id])
    render "static_pages/daily_inspection_edit"
  end

  def daily_inspection_update
    @daily_inspection = DailyInspection.find(params[:id])
    if @daily_inspection.update(daily_inspection_params)
      render "static_pages/daily_inspection_show", status: :ok
    else
      flash.now[:danger] = @daily_inspection.errors.full_messages.join("、")
      render "static_pages/daily_inspection_edit", status: :unprocessable_entity
    end
  end

  def daily_inspection_destroy
    @daily_inspection = DailyInspection.find(params[:id])
    @daily_inspection.destroy
    render html: "<script>window.opener.location.reload(); window.close();</script>".html_safe, layout: false
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
    if current_user.aircraft.blank?
      flash.now[:danger] = "先に機体登録してください。(サイドメニュー押すと戻ります)"
      @aircrafts = [ current_user.aircraft ].compact
      render "static_pages/inspection_maintenance_index", status: :ok
      return
    end
    if current_user.aircraft.inspection_maintenance.present?
      flash.now[:danger] = "既に点検整備記録が登録されています。編集画面をご利用ください。(サイドメニュー押すと戻ります)"
      @aircrafts = [ current_user.aircraft ].compact
      @inspection_maintenances = current_user.aircraft.inspection_maintenance
      render "static_pages/inspection_maintenance_index", status: :ok
      return
    end
    @aircrafts = [ current_user.aircraft ].compact
    @inspection_maintenance = current_user.aircraft.build_inspection_maintenance
  end

  def inspection_maintenance_edit
    @aircrafts = [ current_user.aircraft ].compact
    @inspection_maintenance = InspectionMaintenance.find(params[:id])
    render "static_pages/inspection_maintenance_edit"
  end

  def inspection_maintenance_update
    @inspection_maintenance = InspectionMaintenance.find(params[:id])

    data = inspection_maintenance_params
    data[:inspection_maintenance_items_attributes]&.each do |_, item|
      if item[:item_date].present?
        item[:item_total_flight_time] = calculate_total_flight_time(item[:item_date])
      end
    end

    if @inspection_maintenance.update(data)
      render "static_pages/inspection_maintenance_show", status: :ok
    else
      flash.now[:danger] = @inspection_maintenance.errors.full_messages.join("、")
      render "static_pages/inspection_maintenance_edit", status: :unprocessable_entity
    end
  end

  def inspection_maintenance_destroy
    @inspection_maintenance = InspectionMaintenance.find(params[:id])
    @inspection_maintenance.destroy
    render html: "<script>window.opener.location.reload(); window.close();</script>".html_safe, layout: false
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

  def flight_log_params
    params.require(:flight_log).permit(
      :flight_date, :aircraft_id,
      flight_records_attributes: [
        :id, :pilot_name, :takeoff_time, :landing_time,
        :takeoff_location, :landing_location,
        :flight_summary, :has_safety_incident,
        safety_incident_attributes: [
          :id, :details_issues, :details_date_resolution,
          :details_processing, :details_verifier
        ]
      ]
    )
  end

  def inspection_maintenance_params
    params.require(:inspection_maintenance).permit(
      :special_notes, :aircraft_id,
      inspection_maintenance_items_attributes: [
        :id, :item_date, :item_total_flight_time, :item_maintenance_details,
        :item_reson_implementation, :item_location, :item_organizer, :item_note
      ]
    )
  end

  def daily_inspection_params
    params.require(:daily_inspection).permit(
      :aircraft_id,
      :inspection_date,
      :inspection_location,
      :inspector,
      :special_notes,
      daily_inspection_items_attributes: [
        :id,
        :item_name,
        :result,
        :note
      ]
    )
  end
end
