require "rails_helper"

RSpec.describe "Sessions", type: :request do
  let(:user) { users(:lazaro_nixon) }

  it "should get index" do
    sign_in(user)

    get sessions_url
    expect(response).to have_http_status(:success)
  end

  it "should get new" do
    get sign_in_url
    expect(response).to have_http_status(:success)
  end

  it "should sign in" do
    post sign_in_url, params: { email: user.email, password: "Secret1*3*5*" }
    assert_enqueued_email_with SessionMailer, :signed_in_notification, args: { session: user.sessions.last }

    expect(response).to redirect_to(root_path)

    get root_url
    expect(response).to have_http_status(:success)
  end

  it "should not sign in with wrong credentials" do
    post sign_in_url, params: { email: user.email, password: "SecretWrong1*3" }
    expect(response).to redirect_to(sign_in_url(email_hint: user.email))
    expect(flash[:alert]).to eq("That email or password is incorrect")
  end

  it "should sign out" do
    sign_in(user)

    delete session_url(user.sessions.last)
    expect(response).to redirect_to(sessions_url)

    follow_redirect!
    assert_redirected_to sign_in_url
  end
end
