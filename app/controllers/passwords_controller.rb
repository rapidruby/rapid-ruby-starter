class PasswordsController < ApplicationController
  before_action :set_user

  def update
    if !@user.authenticate(params[:current_password])
      redirect_to identity_account_path, alert: "The current password you entered is incorrect"
    elsif @user.update(user_params)
      redirect_to identity_account_path, notice: "Your password has been changed"
    else
      # render :edit, status: :unprocessable_entity
      render turbo_stream: turbo_stream.replace(
        "change_password_form",
        partial: "passwords/form"
      )
    end
  end

  private
    def set_user
      @user = Current.user
    end

    def user_params
      params.permit(:password, :password_confirmation)
    end
end
