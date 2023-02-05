require "rails_helper"

RSpec.describe "RegistrationsTest", type: :feature do
  it "allows signing up" do
    visit sign_up_url

    fill_in "First name", with: "Jane"
    fill_in "Last name", with: "Nixon"
    fill_in "Email", with: "janenixon@hey.com"
    fill_in "Password", with: "Secret6*4*2*"
    fill_in "Password confirmation", with: "Secret6*4*2*"
    check "terms_and_conditions"
    within ".form-actions" do
      click_on "Sign up"
    end

    assert_text "Welcome! You have signed up successfully"
  end
end
