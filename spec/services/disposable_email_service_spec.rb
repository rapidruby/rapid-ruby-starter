require "rails_helper"

RSpec.describe DisposableEmailService do
  describe "#disposable?(email)" do
    it "returns false when the email domain is NOT disposable" do
      expect(described_class.disposable?("hi@rapidruby.com")).to be(false)
    end

    it "returns true when the email domain is disposable" do
      expect(described_class.disposable?("info@zyzs.freeml.net")).to be(true)
    end
  end
end
