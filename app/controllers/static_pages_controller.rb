class StaticPagesController < ApplicationController
  def aircraft_list_index
    #   @aircrafts = Aircraft.includes(:user)
    @aircrafts = [ current_user.aircraft ].compact
  end

  def aircraft_show
  end

  def aircraft_new
  end

  def aircraft_edit
  end


  def flight_log_index
    @aircrafts = [ current_user.aircraft ].compact   # view側アソシエーション対応とした。box2 renderで必要。2026.6/24
    @flight_logs = current_user.aircraft.flight_logs
  end

  def flight_log_show
  end

  def flight_log_new
  end

  def flight_log_edit
  end


  def daily_inspection_index
    @aircrafts = [ current_user.aircraft ].compact   # view側アソシエーション対応とした。box2 renderで必要。2026.6/24
    @daily_inspections = current_user.aircraft.daily_inspections
  end

  def daily_inspection_show
  end

  def daily_inspection_new
  end

  def daily_inspection_edit
  end


  def inspection_maintenance_index
    @aircrafts = [ current_user.aircraft ].compact
    @inspection_maintenances = current_user.aircraft.inspection_maintenance
  end

  def inspection_maintenance_show
  end

  def inspection_maintenance_new
  end

  def inspection_maintenance_edit
  end

  def delete_confirm_index
    render layout: "minimal"
  end
end
