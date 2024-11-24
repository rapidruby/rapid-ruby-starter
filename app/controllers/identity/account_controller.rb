class Identity::AccountController < ApplicationController
  def show
    @user = Current.user
  end

  def update
    @user = Current.user

    if @user.update(update_params)
      redirect_to identity_account_path, notice: "Personal details updated!"
    else
      render :show
    end
  end

  private

  def update_params
    params.require(:user).permit(:first_name, :last_name, :avatar)
  end
end
