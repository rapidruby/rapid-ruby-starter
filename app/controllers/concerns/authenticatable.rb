module Authenticatable
  extend ActiveSupport::Concern

  included do
    before_action :set_current_request_details
    before_action :load_session
    before_action :authenticate

    helper_method :user_signed_in?
  end

  def user_signed_in?
    Current.user.present?
  end

  def load_session
    if session = Session.find_by_id(cookies.signed[:session_token])
      Current.session = session
    end
  end

  def authenticate
    redirect_to(sign_in_path) unless user_signed_in?
  end

  def set_current_request_details
    Current.user_agent = request.user_agent
    Current.ip_address = request.ip
  end
end
