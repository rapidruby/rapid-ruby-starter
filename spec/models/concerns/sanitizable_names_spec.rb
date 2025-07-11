require "rails_helper"

RSpec.describe SanitizableNames do
  # Create a test model that includes the concern
  let(:test_class) do
    Class.new(ApplicationRecord) do
      self.table_name = "users"
      include SanitizableNames

      attr_accessor :first_name, :last_name, :name
    end
  end

  let(:test_instance) { test_class.new }

  describe "#sanitize_name_field" do
    it "removes URLs from names" do
      result = test_instance.send(:sanitize_name_field, "John https://example.com Doe")
      expect(result).to eq("John Doe")
    end

    it "removes www URLs from names" do
      result = test_instance.send(:sanitize_name_field, "Jane www.example.com Smith")
      expect(result).to eq("Jane Smith")
    end

    it "removes HTML tags from names" do
      result = test_instance.send(:sanitize_name_field, "Bob <script>alert('xss')</script> Johnson")
      expect(result).to eq("Bob alert('xss') Johnson")
    end

    it "removes emojis from names" do
      result = test_instance.send(:sanitize_name_field, "Alice 😀🚀🏁 Cooper")
      expect(result).to eq("Alice Cooper")
    end

    it "removes suspicious characters" do
      result = test_instance.send(:sanitize_name_field, "Charlie:<>/Test")
      expect(result).to eq("CharlieTest")
    end

    it "squeezes multiple spaces into single spaces" do
      result = test_instance.send(:sanitize_name_field, "David    Multiple   Spaces")
      expect(result).to eq("David Multiple Spaces")
    end

    it "strips leading and trailing whitespace" do
      result = test_instance.send(:sanitize_name_field, "  Eve Trimmed  ")
      expect(result).to eq("Eve Trimmed")
    end

    it "returns nil for non-string input" do
      result = test_instance.send(:sanitize_name_field, nil)
      expect(result).to be_nil
    end

    it "handles complex mixed input" do
      dirty_name = "  <b>Frank</b> 😎 https://badsite.com Johnson:<test>  "
      result = test_instance.send(:sanitize_name_field, dirty_name)
      expect(result).to eq("Frank Johnson")
    end
  end

  describe "#sanitize_text" do
    it "provides public access to sanitization" do
      result = test_instance.sanitize_text("Test 😀 https://example.com Text")
      expect(result).to eq("Test Text")
    end
  end

  describe "before_validation callback" do
    it "sanitizes first_name when present" do
      test_instance.first_name = "John 😀 Doe"
      test_instance.valid?
      expect(test_instance.first_name).to eq("John Doe")
    end

    it "sanitizes last_name when present" do
      test_instance.last_name = "Smith https://example.com"
      test_instance.valid?
      expect(test_instance.last_name).to eq("Smith")
    end

    it "doesn't break when fields are not present" do
      expect { test_instance.valid? }.not_to raise_error
    end

    it "handles spam attack on happi" do
      test_instance.first_name = ">>> https://graph.org/107717go-05-07
 <<< 40828899"
      test_instance.last_name = ">>> https://graph.org/107717go-05-07
 <<< 40828899"
      test_instance.valid?
      expect(test_instance.first_name).to eq("40828899")
      expect(test_instance.last_name).to eq("40828899")
    end

    it "handles spam attack on idea pilot" do
      test_instance.first_name = "✨Tek Tıkla Bonusunuz - 80.000 Lira Kazanın https://bit.ly/4l6aawq ✨"
      test_instance.valid?
      expect(test_instance.first_name).to eq("Tek Tıkla Bonusunuz - 80.000 Lira Kazanın")
    end
  end
end
