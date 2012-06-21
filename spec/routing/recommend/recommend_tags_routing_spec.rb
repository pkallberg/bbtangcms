require "spec_helper"

describe Recommend::RecommendTagsController do
  describe "routing" do

    it "routes to #index" do
      get("/recommend/recommend_tags").should route_to("recommend/recommend_tags#index")
    end

    it "routes to #new" do
      get("/recommend/recommend_tags/new").should route_to("recommend/recommend_tags#new")
    end

    it "routes to #show" do
      get("/recommend/recommend_tags/1").should route_to("recommend/recommend_tags#show", :id => "1")
    end

    it "routes to #edit" do
      get("/recommend/recommend_tags/1/edit").should route_to("recommend/recommend_tags#edit", :id => "1")
    end

    it "routes to #create" do
      post("/recommend/recommend_tags").should route_to("recommend/recommend_tags#create")
    end

    it "routes to #update" do
      put("/recommend/recommend_tags/1").should route_to("recommend/recommend_tags#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/recommend/recommend_tags/1").should route_to("recommend/recommend_tags#destroy", :id => "1")
    end

  end
end
