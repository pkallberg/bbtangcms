require "spec_helper"

describe Recommend::RecommendAppsController do
  describe "routing" do

    it "routes to #index" do
      get("/recommend/recommend_apps").should route_to("recommend/recommend_apps#index")
    end

    it "routes to #new" do
      get("/recommend/recommend_apps/new").should route_to("recommend/recommend_apps#new")
    end

    it "routes to #show" do
      get("/recommend/recommend_apps/1").should route_to("recommend/recommend_apps#show", :id => "1")
    end

    it "routes to #edit" do
      get("/recommend/recommend_apps/1/edit").should route_to("recommend/recommend_apps#edit", :id => "1")
    end

    it "routes to #create" do
      post("/recommend/recommend_apps").should route_to("recommend/recommend_apps#create")
    end

    it "routes to #update" do
      put("/recommend/recommend_apps/1").should route_to("recommend/recommend_apps#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/recommend/recommend_apps/1").should route_to("recommend/recommend_apps#destroy", :id => "1")
    end

  end
end
