class Identity::EmailVerificationsController < ApplicationController
  skip_before_action :authenticate, only: :edit

  before_action :set_user, only: :edit

  def edit
    @user.update! verified: true
    redirect_to identity_account_path, notice: "Thank you for verifying your email address"
  end

  def create
    UserMailer.with(user: Current.user).email_verification.deliver_later
    redirect_to identity_account_path, notice: "We sent a verification email to your email address"
  end

  private
    def set_user
      @token = EmailVerificationToken.find_signed!(params[:sid]); @user = @token.user
    rescue
      redirect_to identity_account_path, alert: "That email verification link is invalid"
    end
end
