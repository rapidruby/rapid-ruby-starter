class Current < ActiveSupport::CurrentAttributes
  attribute :session, :user, :team
  attribute :user_agent, :ip_address

  def session=(session)
    super
    self.user = session.user
    self.team = user.team
  end
end
