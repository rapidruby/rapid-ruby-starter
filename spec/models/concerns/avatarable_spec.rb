require "rails_helper"

RSpec.describe Avatarable, type: :model do
  let(:user) { users(:pete) }

  describe "#letters_svg" do
    it "returns an svg of initials" do
      svg = user.letters_svg
      expect(svg).to include("PH")
    end
  end
end
