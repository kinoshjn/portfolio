class InquiriesController < ApplicationController
  def  new
  end

  def create
    mail = InquiriesMailer.notify(current_user.user_name, current_user.email, params[:content])
    mail.deliver_now
    render "static_pages/aircraft_list_index"
  end
end
