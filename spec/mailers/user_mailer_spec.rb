require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { users(:lazaro_nixon) }

  it "#password_reset" do
    mail = UserMailer.with(user: user).password_reset
    expect(mail.subject).to eq("Reset your password")
    expect(mail.to.first).to eq(user.email)
  end

  it "#email_verification" do
    mail = UserMailer.with(user: user).email_verification
    expect(mail.subject).to eq("Verify your email")
    expect(mail.to.first).to eq(user.email)
  end
end
