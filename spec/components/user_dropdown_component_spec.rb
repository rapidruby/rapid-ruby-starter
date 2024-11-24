# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserDropdownComponent, type: :component do
  let(:user) { users(:pete) }
  let(:session) { Session.create!(user: user) }

  it "renders something useful" do
    render_inline(described_class.new(current_user: user, current_session: session))

    expect(page).to have_content(user.email)
  end
end
