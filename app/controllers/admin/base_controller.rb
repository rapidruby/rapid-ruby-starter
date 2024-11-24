module Admin
  class BaseController < ApplicationController
    before_action :ensure_admin!

    private

    def ensure_admin!
      return redirect_to root_path if Current.user.blank?

      unless Current.user.admin?
        redirect_to root_path, alert: "You are not an admin"
      end
    end
  end
end
