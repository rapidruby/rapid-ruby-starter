# frozen_string_literal: true

class Admin::MasqueradeComponent < ApplicationComponent
  option :session

  def render?
    return false if session.blank?

    session.masquerading?
  end
end
