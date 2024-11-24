class Session < ApplicationRecord
  belongs_to :user
  belongs_to :admin_user, class_name: "User", optional: true

  before_create do
    self.user_agent = Current.user_agent
    self.ip_address = Current.ip_address
  end

  after_create_commit do
    SessionMailer.with(session: self).signed_in_notification.deliver_later
  end

  def masquerade_as!(other_user)
    self.masquerade_at = Time.current
    self.admin_user = user
    self.user = other_user
    save!
  end

  def masquerading?
    admin_user.present?
  end

  def reverse_masquerade!
    return unless masquerading?

    self.masquerade_at = nil
    self.user = admin_user
    self.admin_user = nil
    save!
  end
end
