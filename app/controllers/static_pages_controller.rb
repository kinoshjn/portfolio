class StaticPagesController < ApplicationController
  def aircraft_list_index
  end

  def aircraft_show
  end

  def aircraft_new
  end

  def aircraft_edit
  end


  def flight_log_index
  end

  def daily_inspection_index
  end

  def inspection_and_maintenance_index
  end

  def delete_confirm_index
    render layout: "minimal"
  end

end
