require "rails_helper"

RSpec.describe "Identity::EmailsTest", type: :feature do
  let!(:user) { sign_in_as(users(:lazaro_nixon)) }

  it "updates the email" do
    click_on "Change email address"

    fill_in "New email", with: "new_email@hey.com"
    click_on "Save changes"

    assert_text "Your email has been changed"
  end

  it "sends a verification email" do
    user.update! verified: false

    click_on "Change email address"
    assert_current_path "/identity/email/edit"
    click_on "Re-send verification email"

    assert_text "We sent a verification email to your email address"
  end
end
