class FlightLogsController < ApplicationController
  before_action :require_login

  def index
    @aircrafts = [ current_user.aircraft ].compact
    logs = current_user.aircraft.present? ? current_user.aircraft.flight_logs : FlightLog.none
    @q = logs.ransack(params[:q])
    @flight_logs = @q.result
    render "static_pages/flight_log_index"
  end

  def show
    @flight_log =FlightLog.find(params[:id])
    render "static_pages/flight_log_show"
  end


def create
  flight_log_data = flight_log_params

  # has_safety_incident: trueの件数を確認
  safety_incident_count = 0
  si_input_count = 0

  flight_log_data[:flight_records_attributes]&.each do |_, record|
    if record[:has_safety_incident] == "true"
      safety_incident_count += 1
      if record[:safety_incident_attributes].present? &&
         record[:safety_incident_attributes][:details_issues].present?
        si_input_count += 1
      end
    else
      record.delete(:safety_incident_attributes)
    end
  end

  # ありの件数と入力件数が一致しない場合は保存しない
  if safety_incident_count != si_input_count
    @flight_log = current_user.aircraft.flight_logs.build(flight_log_data)
    @flight_log.errors.add(:base, "安全影響事項ありの件数と不具合事項の入力件数が一致していません")
    render "static_pages/flight_log_new", status: :unprocessable_entity
    return
  end

  @flight_log = current_user.aircraft.flight_logs.build(flight_log_data)
  if @flight_log.save
    render "static_pages/flight_log_show", status: :ok
  else
    render "static_pages/flight_log_new", status: :unprocessable_entity
  end
end

private

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
end
