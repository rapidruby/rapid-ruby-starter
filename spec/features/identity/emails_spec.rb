require "rails_helper"

RSpec.describe "Identity::EmailsTest", type: :feature do
  let!(:user) { sign_in_as(users(:lazaro_nixon)) }

  it "updates the email" do
    click_on "Manage account", match: :first

    within("#change_email_form") do
      fill_in "New email", with: "new_email@hey.com"
      click_on "Save changes"
    end

    assert_text "Your email has been changed"
  end

  it "sends a verification email" do
    user.update! verified: false

    click_on "Manage account", match: :first
    assert_current_path "/identity/account"
    click_on "Re-send verification email"

    assert_text "We sent a verification email to your email address"
  end
end
