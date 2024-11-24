require "rails_helper"

RSpec.describe Identity::EmailsController, type: :request do
  let(:user) { users(:lazaro_nixon) }
  before { sign_in(user) }

  describe "#update" do
    it "should update email" do
      patch identity_email_url, params: { email: "new_email@hey.com" }
      expect(response).to redirect_to(root_url)
    end

    it "responds with a turbo_stream when validation fails" do
      patch identity_email_url, params: { email: "new_email" }

      expect(response).to have_http_status(:success)
      assert_select("turbo-stream[action='replace'][target='change_email_form']", 1)
      expect(response.body).to include("Email is invalid")
    end
  end
end
