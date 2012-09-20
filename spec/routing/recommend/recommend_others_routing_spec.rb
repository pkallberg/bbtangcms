require "spec_helper"

describe Recommend::RecommendOthersController do
  describe "routing" do

    it "routes to #index" do
      get("/recommend/recommend_others").should route_to("recommend/recommend_others#index")
    end

    it "routes to #new" do
      get("/recommend/recommend_others/new").should route_to("recommend/recommend_others#new")
    end

    it "routes to #show" do
      get("/recommend/recommend_others/1").should route_to("recommend/recommend_others#show", :id => "1")
    end

    it "routes to #edit" do
      get("/recommend/recommend_others/1/edit").should route_to("recommend/recommend_others#edit", :id => "1")
    end

    it "routes to #create" do
      post("/recommend/recommend_others").should route_to("recommend/recommend_others#create")
    end

    it "routes to #update" do
      put("/recommend/recommend_others/1").should route_to("recommend/recommend_others#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/recommend/recommend_others/1").should route_to("recommend/recommend_others#destroy", :id => "1")
    end

  end
end
