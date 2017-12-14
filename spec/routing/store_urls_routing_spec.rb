require "rails_helper"

RSpec.describe StoreUrlsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/store_urls").to route_to("store_urls#index")
    end

    it "routes to #new" do
      expect(:get => "/store_urls/new").to route_to("store_urls#new")
    end

    it "routes to #show" do
      expect(:get => "/store_urls/1").to route_to("store_urls#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/store_urls/1/edit").to route_to("store_urls#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/store_urls").to route_to("store_urls#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/store_urls/1").to route_to("store_urls#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/store_urls/1").to route_to("store_urls#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/store_urls/1").to route_to("store_urls#destroy", :id => "1")
    end

  end
end
