require "rails_helper"

RSpec.describe "Identity::AccountController", type: :request do
  let(:user) { users(:pete) }
  before { sign_in(user) }

  describe "GET /" do
    it "should load without errors" do
      get identity_account_url
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /" do
    it "should load without errors" do
      patch identity_account_url, params: {
        user: {
          first_name: "New first name",
          last_name: "New last name"
        }
      }
      expect(response).to redirect_to(identity_account_url)
      expect(user.reload.name).to eq("New first name New last name")
    end
  end
end
