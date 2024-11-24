require "rails_helper"

RSpec.describe "Admin Masquerade as another user", type: :request do
  let(:admin_user) { users(:pete) }
  let(:normal_user) { users(:lazaro_nixon) }

  before do
    sign_in(admin_user)
  end

  describe "POST /admin/users/:id/masquerade" do
    it "masquerades as the given user and can reverse masquerade" do
      post masquerade_admin_user_path(normal_user)
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include("You are masquerading as #{normal_user.email}")
      expect(response.body).to include("Return to admin")

      post reverse_masquerade_admin_user_path(admin_user)
      expect(response).to redirect_to(admin_users_path)
      follow_redirect!
      expect(response.body).not_to include("You are masquerading as #{normal_user.email}")
      expect(response.body).to include("Users")
    end
  end
end
