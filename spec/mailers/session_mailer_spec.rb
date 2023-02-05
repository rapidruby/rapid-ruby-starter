require "rails_helper"

RSpec.describe SessionMailer, type: :mailer do
  let(:session) { users(:lazaro_nixon).sessions.create! }

  it "#signed_in_notification" do
    mail = SessionMailer.with(session: session).signed_in_notification
    expect(mail.subject).to eq("New sign-in to your account")
    expect(mail.to.first).to eq(session.user.email)
  end
end
