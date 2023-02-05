require "rails_helper"

RSpec.describe "PasswordsTest", type: :feature do
  before { sign_in_as(users(:lazaro_nixon)) }

  it "updating the password" do
    click_on "Change password", match: :first

    fill_in "Current password", with: "Secret1*3*5*"
    fill_in "New password", with: "Secret6*4*2*"
    fill_in "Confirm new password", with: "Secret6*4*2*"
    click_on "Save changes"

    assert_text "Your password has been changed"
  end
end
