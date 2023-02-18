require "rails_helper"

RSpec.describe "Lessons", type: :request do
  describe "GET /lessons" do
    it "returns http success" do
      get "/lessons"
      expect(response).to have_http_status(:success)
    end
  end
end
