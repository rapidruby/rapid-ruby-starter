class SessionsController < ApplicationController
  # Rate limit login attempts by IP (5 attempts per 20 minutes)
  rate_limit to: 5, within: 20.minutes, only: :create, name: "login_ip",
    with: -> { render plain: "Rate limit exceeded. Please try again later.\n", status: :too_many_requests }

  # Rate limit login attempts by email (5 attempts per 20 minutes)
  rate_limit to: 5, within: 20.minutes, only: :create, name: "login_email",
    by: -> { params[:email]&.downcase || request.ip },
    with: -> { render plain: "Rate limit exceeded. Please try again later.\n", status: :too_many_requests }

  skip_before_action :authenticate, only: %i[ new create ]
  before_action :ensure_signed_out!, only: %i[ new create ]

  before_action :set_session, only: :destroy

  def index
    @sessions = Current.user.sessions.order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      @session = user.sessions.create!
      cookies.signed.permanent[:session_token] = { value: @session.id, httponly: true }

      redirect_to root_path, notice: "Signed in successfully"
    else
      redirect_to sign_in_path(email_hint: params[:email]), alert: "That email or password is incorrect"
    end
  end

  def destroy
    if Current.session == @session
      @session.destroy
      cookies.signed.permanent[:session_token] = nil
      redirect_to(root_path, notice: "You have been logged out")
    else
      @session.destroy
      redirect_to(sessions_path, notice: "That session has been logged out")
    end
  end

  private

  def set_session
    @session = Current.user.sessions.find(params[:id])
  end
end
