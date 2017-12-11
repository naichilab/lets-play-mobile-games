require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  describe "GET #policy" do
    it "returns http success" do
      get :policy
      expect(response).to have_http_status(:success)
    end
  end

end
