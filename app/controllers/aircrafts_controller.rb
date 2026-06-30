class AircraftsController < ApplicationController
  before_action :require_login

  def index
    @aircrafts = [ current_user.aircraft ].compact  # root時AircraftsController#indexのため削除不可。
    #    @aircrafts = Aircraft.includes(:user)
    render "static_pages/aircraft_list_index"
  end

  def show
    @aircraft = Aircraft.find(params[:id])
    render "static_pages/aircraft_show"
  end

  def create
    @aircraft = current_user.build_aircraft(aircraft_params)
    if @aircraft.save
      render "static_pages/aircraft_show", status: :ok
    else
      render "static_pages/aircraft_new", status: :unprocessable_entity
    end
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
