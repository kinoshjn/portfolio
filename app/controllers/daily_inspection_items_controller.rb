class DailyInspectionItemsController < ApplicationController
  def index
    @daily_inspection_items = Daily_inspection_item.includes(:daily_inspection)
  end
end
