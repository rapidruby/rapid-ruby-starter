require "rails_helper"

RSpec.describe "Courses", type: :request do
  describe "GET /courses" do
    it "returns http success" do
      get "/courses"
      expect(response).to have_http_status(:success)
    end
  end
end
