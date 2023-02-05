require "rails_helper"

RSpec.describe "Identity::EmailsController", type: :request do
  let(:user) { users(:lazaro_nixon) }
  before { sign_in(user) }

  it "should get edit" do
    get edit_identity_email_url
    expect(response).to have_http_status(:success)
  end

  it "should update email" do
    patch identity_email_url, params: { email: "new_email@hey.com" }
    expect(response).to redirect_to(root_url)
  end
end
