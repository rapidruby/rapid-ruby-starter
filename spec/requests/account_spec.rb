require "rails_helper"

RSpec.describe "Accounts", type: :request do
  describe "GET /account" do
    it "returns http success" do
      sign_in(users(:lazaro_nixon))
      get "/account"
      expect(response).to have_http_status(:success)
    end
  end
end
