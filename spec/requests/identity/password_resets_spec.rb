require "rails_helper"

RSpec.describe "Identity::PasswordResetsController", type: :request do
  let(:user) { users(:lazaro_nixon) }

  it "should get new" do
    get new_identity_password_reset_url
    expect(response).to have_http_status(:success)
  end

  it "should get edit" do
    sid = user.password_reset_tokens.create.signed_id(expires_in: 20.minutes)

    get edit_identity_password_reset_url(sid: sid)
    expect(response).to have_http_status(:success)
  end

  it "should send a password reset email" do
    perform_enqueued_jobs do
      post identity_password_reset_url, params: { email: user.email }

      expect(last_email.to.first).to eq(user.email)
      expect(last_email.subject).to eq("Reset your password")

      expect(response).to redirect_to(sign_in_url)
    end
  end

  it "should not send a password reset email to a nonexistent email" do
    post identity_password_reset_url, params: { email: "invalid_email@hey.com" }

    expect(last_email).to be_nil

    expect(response).to redirect_to(new_identity_password_reset_url)
    expect(flash[:alert]).to eq("You can't reset your password until you verify your email")
  end

  it "should not send a password reset email to a unverified email" do
    user.update! verified: false

    post identity_password_reset_url, params: { email: user.email }

    expect(last_email).to be_nil

    expect(response).to redirect_to(new_identity_password_reset_url)
    expect(flash[:alert]).to eq("You can't reset your password until you verify your email")
  end

  it "should update password" do
    sid = user.password_reset_tokens.create.signed_id(expires_in: 20.minutes)

    patch identity_password_reset_url, params: { sid: sid, password: "Secret6*4*2*", password_confirmation: "Secret6*4*2*" }
    expect(response).to redirect_to(sign_in_url)
  end

  it "should not update password with expired token" do
    sid_exp = user.password_reset_tokens.create.signed_id(expires_in: 0.minutes)

    patch identity_password_reset_url, params: { sid: sid_exp, password: "Secret6*4*2*", password_confirmation: "Secret6*4*2*" }
    expect(response).to redirect_to(new_identity_password_reset_url)
    expect(flash[:alert]).to eq("That password reset link is invalid")
  end
end
