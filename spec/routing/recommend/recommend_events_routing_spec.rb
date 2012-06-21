require "spec_helper"

describe Recommend::RecommendEventsController do
  describe "routing" do

    it "routes to #index" do
      get("/recommend/recommend_events").should route_to("recommend/recommend_events#index")
    end

    it "routes to #new" do
      get("/recommend/recommend_events/new").should route_to("recommend/recommend_events#new")
    end

    it "routes to #show" do
      get("/recommend/recommend_events/1").should route_to("recommend/recommend_events#show", :id => "1")
    end

    it "routes to #edit" do
      get("/recommend/recommend_events/1/edit").should route_to("recommend/recommend_events#edit", :id => "1")
    end

    it "routes to #create" do
      post("/recommend/recommend_events").should route_to("recommend/recommend_events#create")
    end

    it "routes to #update" do
      put("/recommend/recommend_events/1").should route_to("recommend/recommend_events#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/recommend/recommend_events/1").should route_to("recommend/recommend_events#destroy", :id => "1")
    end

  end
end
