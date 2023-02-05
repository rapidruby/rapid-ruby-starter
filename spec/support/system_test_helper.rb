module SystemTestHelper
  def sign_in_as(user)
    visit sign_in_url
    fill_in :email, with: user.email
    fill_in :password, with: "Secret1*3*5*"
    click_on "Sign in"

    assert_current_path root_path
    user
  end

  def open_debug!
    page.driver.debug(binding)
  end
end

RSpec.configure do |config|
  config.include SystemTestHelper, type: :feature
end
