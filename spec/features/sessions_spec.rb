require "rails_helper"

RSpec.describe "SessionsTest", type: :feature do
  before do
    @user = users(:lazaro_nixon)
  end

  it "visiting the index" do
    sign_in_as @user

    click_on "Devices & Sessions", match: :first
    assert_selector "h1", text: "Sessions"
  end

  it "signing in" do
    visit sign_in_url
    fill_in "Email", with: @user.email
    fill_in "Password", with: "Secret1*3*5*"
    click_on "Sign in"

    assert_text "Signed in successfully"
  end

  it "signing out" do
    sign_in_as @user

    click_on "Log out", match: :first
    assert_text "That session has been logged out"
  end
end
