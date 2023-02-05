module RequestHelper
  def sign_in(user)
    post(sign_in_url, params: { email: user.email, password: "Secret1*3*5*" }); user
  end
end

RSpec.configure do |config|
  config.include RequestHelper, type: :request
  config.before(:each, type: :request) { host! "rapidrubystarter.test" }
end
