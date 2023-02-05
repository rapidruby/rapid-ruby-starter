module SystemTestHelper
  def sign_in_as(user)
    visit sign_in_url
    fill_in :email, with: user.email
    fill_in :password, with: "Secret1*3*5*"
    click_on "Sign in"

    assert_current_path lessons_path
    user
  end
end

RSpec.configure { |config| config.include SystemTestHelper, type: :feature }
