class ApplicationController < ActionController::Base
  private

  def nav_links
    NavLink.all
  end
  helper_method :nav_links
end
