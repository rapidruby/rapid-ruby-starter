require "rails_helper"

RSpec.describe MarkdownService do
  describe ".to_html" do
    it "converts markdown to HTML" do
      html = described_class.to_html("# Hello")
      expect(html).to eq("<h1>Hello</h1>\n")
    end

    it "adds target: _blank and rel: noopener to links" do
      html = described_class.to_html("[Google](https://google.com)")
      expect(html).to eq('<p><a href="https://google.com" rel="nofollow noreferer noopener" target="_blank">Google</a></p>' + "\n")
    end

    it "handles nil" do
      html = described_class.to_html(nil)
      expect(html).to eq("")
    end

    it "handles invalid input like integers" do
      expect { described_class.to_html(42) }.to raise_error(ArgumentError, "Input must be a string or nil")
    end
  end
end
