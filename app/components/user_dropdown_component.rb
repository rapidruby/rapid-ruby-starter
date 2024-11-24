# frozen_string_literal: true

class UserDropdownComponent < ApplicationComponent
  option :current_user
  option :current_session

  def render?
    current_user.present? && current_session.present?
  end
end
