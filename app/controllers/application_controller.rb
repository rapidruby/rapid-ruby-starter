class ApplicationController < ActionController::Base
  before_action :set_current_request_details
  before_action :authenticate

  private

  def authenticate
    if session = Session.find_by_id(cookies.signed[:session_token])
      Current.session = session
    else
      redirect_to sign_in_path
    end
  end

  def set_current_request_details
    Current.user_agent = request.user_agent
    Current.ip_address = request.ip
  end

  def nav_links
    NavLink.all
  end
  helper_method :nav_links
end
