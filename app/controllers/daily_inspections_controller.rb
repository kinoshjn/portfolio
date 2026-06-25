class DailyInspectionsController < ApplicationController
  before_action :require_login

  def index
    #    @daily_inspections = Daily_inspection.includes(:aircraft)
    render "static_pages/daily_inspection_index"
  end
end
