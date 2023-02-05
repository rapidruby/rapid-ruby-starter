require "rails_helper"

RSpec.describe "RegistrationsController", type: :request do
  it "should get new" do
    get sign_up_url
    expect(response).to have_http_status(:success)
  end

  it "should sign up" do
    allow(HcaptchaService).to receive(:success?).and_return(true)

    expect do
      post sign_up_url, params: { first_name: "New", last_name: "User", email: "newuser@hey.com", password: "Secret1*3*5*", password_confirmation: "Secret1*3*5*" }
    end.to change(User, :count).by(1)

    expect(response).to redirect_to(root_path)
  end
end
