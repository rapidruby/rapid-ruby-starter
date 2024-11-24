require "rails_helper"

RSpec.describe "Identity::EmailVerificationsController", type: :request do
  let(:user) { users(:lazaro_nixon) }
  before do
    sign_in(user)
    user.update! verified: false
  end

  it "should send a verification email" do
    perform_enqueued_jobs do
      post identity_email_verification_url

      expect(last_email.to.first).to eq(user.email)
      expect(last_email.subject).to eq("Verify your email")

      expect(response).to redirect_to(identity_account_path)
    end
  end

  it "should verify email" do
    sid = user.email_verification_tokens.create.signed_id(expires_in: 2.days)

    get edit_identity_email_verification_url(sid: sid, email: user.email)
    expect(response).to redirect_to(identity_account_path)
  end

  it "should not verify email with expired token" do
    sid_exp = user.email_verification_tokens.create.signed_id(expires_in: 0.minutes)

    get edit_identity_email_verification_url(sid: sid_exp, email: user.email)

    expect(response).to redirect_to(identity_account_url)
    expect(flash[:alert]).to eq("That email verification link is invalid")
  end
end
