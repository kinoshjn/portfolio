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

end
