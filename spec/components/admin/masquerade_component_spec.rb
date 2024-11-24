# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::MasqueradeComponent, type: :component do
  it "renders a masquerade banner if masquerading" do
    user = double(:user, email: "test@example.com")
    admin_user = double(:admin_user, email: "admin@example.com")
    session = double(:session, masquerading?: true, user: user, admin_user: admin_user)

    render_inline(described_class.new(session: session))

    expect(page).to have_text("You are masquerading as #{session.user.email}")
  end

  it "doesn't render if not masquerading" do
    session = double(:session, masquerading?: false)

    render_inline(described_class.new(session: session))

    expect(page).to have_no_text("You are masquerading as")
  end

  it "doesn't render if session is blank" do
    session = nil

    render_inline(described_class.new(session: session))

    expect(page).to have_no_text("You are masquerading as")
  end
end
