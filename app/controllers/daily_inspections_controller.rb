class DailyInspectionsController < ApplicationController
  before_action :require_login


  #   2026.7/5  検索機能実装前
  #  def index
  #    render "static_pages/daily_inspection_index"
  #  end

  def index
    @aircrafts = [ current_user.aircraft ].compact
    logs = current_user.aircraft.present? ? current_user.aircraft.daily_inspections  : DailyInspection.none
    @q = logs.ransack(params[:q])
    @daily_inspections = @q.result
    render "static_pages/daily_inspection_index"
  end

  def show
    @daily_inspection = DailyInspection.find(params[:id])
    render "static_pages/daily_inspection_show"
  end


  def create
    daily_inspection_data = daily_inspection_params

    @daily_inspection = current_user.aircraft.daily_inspections.build(daily_inspection_data)


    if @daily_inspection.save
      render "static_pages/daily_inspection_show", status: :ok
    else
      render "static_pages/daily_inspection_new", status: :unprocessable_entity
    end
  end

  private

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
