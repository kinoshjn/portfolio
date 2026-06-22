class StaticPagesController < ApplicationController
  def aircraft_list_index
#    @aircrafts = Aircraft.includes(:user)
    @aircrafts = [current_user.aircraft].compact
  end

  def aircraft_show
  end

  def aircraft_new
  end

  def aircraft_edit
  end


  def flight_log_index
  end

  def flight_log_show
  end

  def flight_log_new
  end

  def flight_log_edit
  end


  def daily_inspection_indexsais
  end

  def daily_inspection_show
  end

  def daily_inspection_new
  end

  def daily_inspection_edit
  end


  def inspection_and_maintenance_index
  end

  def inspection_and_maintenance_show
  end

  def inspection_and_maintenance_new
  end

  def inspection_and_maintenance_edit
  end

  def delete_confirm_index
    render layout: "minimal"
  end
end
