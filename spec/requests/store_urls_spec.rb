require 'rails_helper'

RSpec.describe "StoreUrls", type: :request do
  describe "GET /store_urls" do
    it "works! (now write some real specs)" do
      get store_urls_path
      expect(response).to have_http_status(200)
    end
  end
end
