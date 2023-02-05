require "rails_helper"

RSpec.describe "PagesController", type: :request do
  describe "GET /" do
    context "when signed out" do
      it "renders the landing page and hides the sign out menu" do
        get "/"
        expect(response).to have_http_status(:success)
        expect(response.body).to include("Check out the existing videos")
        expect(response.body).not_to include("All Lessons")

      end
    end

    context "when signed in" do
      it "renders the homepage + navigation menu" do
        sign_in(users(:pete))
        get "/"
        expect(response).to have_http_status(:success)
        expect(response.body).not_to include("Check out the existing videos")
        expect(response.body).to include("All Lessons")
      end
    end
  end

  %w[about terms privacy security].each do |page|
    describe "GET /#{page}" do
      it "renders the #{page} page" do
        get "/#{page}"
        expect(response).to have_http_status(:success)
      end
    end
  end
end
