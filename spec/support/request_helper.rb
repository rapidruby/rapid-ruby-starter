module RequestHelper
  def sign_in(user)
    post(sign_in_url, params: { email: user.email, password: "Secret1*3*5*" }); user
  end
end

RSpec.configure { |config| config.include RequestHelper, type: :request }
