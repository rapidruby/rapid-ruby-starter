require "rails_helper"

RSpec.describe "PasswordsController", type: :request do
  let(:user) { users(:lazaro_nixon) }
  before { sign_in(user) }

  it "should update password" do
    patch password_url, params: { current_password: "Secret1*3*5*", password: "Secret6*4*2*", password_confirmation: "Secret6*4*2*" }
    expect(response).to redirect_to(identity_account_url)
  end

  it "should not update password with wrong current password" do
    patch password_url, params: { current_password: "SecretWrong1*3", password: "Secret6*4*2*", password_confirmation: "Secret6*4*2*" }

    expect(response).to redirect_to(identity_account_url)
    expect(flash[:alert]).to eq("The current password you entered is incorrect")
  end

  it "should respond with a turbo stream when there are errors" do
    patch password_url, params: { format: :turbo_stream, current_password: "Secret1*3*5*", password: "dont", password_confirmation: "match" }

    expect(response).to have_http_status(:success)
    assert_select("turbo-stream[action='replace'][target='change_password_form']", 1)
    expect(response.body).to include("Password is invalid")
  end

  it "redirects to manage account when current_passowrd is invalid" do
    patch password_url, params: { format: :turbo_stream, current_password: "bad_password", password: "dont", password_confirmation: "match" }

    expect(response).to redirect_to(identity_account_url)
    expect(flash[:alert]).to eq("The current password you entered is incorrect")
  end
end
