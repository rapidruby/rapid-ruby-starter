require "rails_helper"

RSpec.describe RegistrationsController, type: :request do
  describe "#new" do
    it "should get new" do
      get sign_up_url
      expect(response).to have_http_status(:success)
    end
  end

  describe "#create" do
    it "signs up the user and creates a team" do
      expect do
        post sign_up_url, params: { first_name: "New", last_name: "User", email: "newuser@hey.com", password: "Secret1*3*5*", password_confirmation: "Secret1*3*5*" }
      end.to change(User, :count).by(1)
        .and change(Team, :count).by(1)

      expect(response).to redirect_to(root_path)
      expect(User.last.team.name).to eq("New’s Team")
    end
  end
end
