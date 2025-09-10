require "rails_helper"

RSpec.describe "Factories" do
  it "has valid factories" do
    FactoryBot.lint traits: true
  end

  it "can create a user with a team" do
    user = create(:user)
    expect(user.team).to be_present
  end
end
