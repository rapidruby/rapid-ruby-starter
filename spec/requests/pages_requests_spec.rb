require "rails_helper"

RSpec.describe PagesController, type: :request do
  describe "#home" do
    it "renders the home page" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end
end
