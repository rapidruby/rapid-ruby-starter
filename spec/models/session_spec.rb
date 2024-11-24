require "rails_helper"

RSpec.describe Session, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:admin_user).optional }
  end

  describe "#masquerade_as!" do
    let(:admin_user) { users(:pete) }
    let(:normal_user) { users(:lazaro_nixon) }

    before do
      admin_user.update!(admin: true)
    end

    it "masquerades as the given user" do
      session = Session.create!(user: admin_user)
      expect(session.masquerading?).to be(false)

      session.masquerade_as!(normal_user)

      expect(session.admin_user).to eq(admin_user)
      expect(session.user).to eq(normal_user)
      expect(session.masquerading?).to be(true)

      session.reverse_masquerade!

      expect(session.admin_user).to be_nil
      expect(session.user).to eq(admin_user)
      expect(session.masquerading?).to be(false)
    end
  end
end
