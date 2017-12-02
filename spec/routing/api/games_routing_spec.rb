require "rails_helper"

RSpec.describe GamesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/api/games").to route_to("api/games#index")
    end

  end
end
