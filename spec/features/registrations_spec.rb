require "rails_helper"

RSpec.describe "RegistrationsTest", type: :feature do
  it "allows signing up" do
    allow(HcaptchaService).to receive(:success?).and_return(true)

    visit sign_up_url

    fill_in "First name", with: "Lazaro"
    fill_in "Last name", with: "Nixon"
    fill_in "Email", with: "lazaronixon@hey.com"
    fill_in "Password", with: "Secret6*4*2*"
    fill_in "Password confirmation", with: "Secret6*4*2*"
    check "terms_and_conditions"
    click_on "Sign up"

    assert_text "Welcome! You have signed up successfully"
  end
end
