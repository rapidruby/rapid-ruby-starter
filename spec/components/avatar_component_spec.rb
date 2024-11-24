require "rails_helper"

RSpec.describe AvatarComponent, type: :component do
  let(:user) { users(:pete) }

  it "renders with default settings" do
    render_inline(described_class.new(user: user))
  end

  it "renders at :thumb size" do
    render_inline(described_class.new(user: user, size: :thumb))
  end
end
