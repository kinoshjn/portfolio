class DailyInspectionsController < ApplicationController
  def index
    @daily_inspections = Daily_inspection.includes(:aircraft)
  end
end
