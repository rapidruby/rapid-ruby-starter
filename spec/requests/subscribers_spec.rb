require "rails_helper"

RSpec.describe "Subscribers", type: :request do
  describe "POST /subscribers" do
    context "when the data is valid" do
      it "creates a newsletter subscriber" do
        expect do
          post "/subscribers", params: {
            newsletter_subscriber: {
              email: "test@example.com"
            }
          }
          expect(response).to have_http_status(:success)
        end.to change(NewsletterSubscriber, :count).by(1)
        subscriber = NewsletterSubscriber.last
        expect(subscriber.email).to eq("test@example.com")
        expect(subscriber.ip_address).not_to be_blank
      end
    end

    context "when the data is invalid" do
      it "displays errors" do
        expect do
          post "/subscribers", params: {
            newsletter_subscriber: {
              email: "test"
            }
          }
          expect(response.body).to include("is not a valid email")
        end.not_to change(NewsletterSubscriber, :count)
      end
    end
  end
end
