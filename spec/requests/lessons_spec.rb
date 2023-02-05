require "rails_helper"

RSpec.describe "Lessons", type: :request do
  describe "GET /lessons" do
    before { videos(:awesome_turbo_frames).update!(created_at: 1.day.from_now) }

    it "returns http success" do
      get "/lessons"
      expect(response).to have_http_status(:success)
    end

    it "excludes unpublished videos" do
      get "/lessons"
      expect(response.body).not_to include("Awesome Turbo Frames, are awesome!")
    end

    context "when signed in as an admin" do
      it "includes unpublished videos for admins" do
        sign_in(users(:pete))
        get "/lessons"
        expect(response.body).to include("Awesome Turbo Frames, are awesome!")
      end
    end
  end

  describe "GET /lessons/:id" do
    let(:video) { videos(:hotwire_drag_and_drop) }

    it "returns http success" do
      get "/lessons/#{video.to_param}"
      expect(response).to have_http_status(:success)
    end
  end
end
