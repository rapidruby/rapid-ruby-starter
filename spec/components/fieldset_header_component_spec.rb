require "rails_helper"

RSpec.describe FieldsetHeaderComponent, type: :component do
  subject(:component) { described_class.new(title: "Title", description: "Description") }

  it "renders the component" do
    render_inline(component)

    expect(page).to have_text("Title")
    expect(page).to have_text("Description")
  end
end
