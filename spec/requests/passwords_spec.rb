require "rails_helper"

RSpec.describe "PasswordsController", type: :request do
  let(:user) { users(:lazaro_nixon) }
  before { sign_in(user) }

  it "should get edit" do
    get edit_password_url
    expect(response).to have_http_status(:success)
  end

  it "should update password" do
    patch password_url, params: { current_password: "Secret1*3*5*", password: "Secret6*4*2*", password_confirmation: "Secret6*4*2*" }
    expect(response).to redirect_to(root_url)
  end

  it "should not update password with wrong current password" do
    patch password_url, params: { current_password: "SecretWrong1*3", password: "Secret6*4*2*", password_confirmation: "Secret6*4*2*" }

    expect(response).to redirect_to(edit_password_url)
    expect(flash[:alert]).to eq("The current password you entered is incorrect")
  end
end
