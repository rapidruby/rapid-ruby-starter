class Session < ApplicationRecord
  belongs_to :user

  before_create do
    self.user_agent = Current.user_agent
    self.ip_address = Current.ip_address
  end

  after_create_commit do
    SessionMailer.with(session: self).signed_in_notification.deliver_later
  end
end
