class RegistrationsController < ApplicationController
  rate_limit to: 5, within: 15.minutes, only: :create,
    with: -> { render plain: "Rate limit exceeded. Please try again later.\n", status: :too_many_requests }

  skip_before_action :authenticate, only: %i[ new create ]
  before_action :ensure_signed_out!, only: %i[ new ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    @user.team = Team.new(name: "#{@user.first_name}’s Team")

    if @user.save
      @user.team.users << @user
      session = @user.sessions.create!
      cookies.signed.permanent[:session_token] = { value: session.id, httponly: true }

      send_email_verification
      redirect_to root_path, notice: "Welcome! You have signed up successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

    def send_email_verification
      UserMailer.with(user: @user).email_verification.deliver_later
    end
end
