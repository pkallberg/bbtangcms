require "spec_helper"

describe Recommend::RecommendPtagsController do
  describe "routing" do

    it "routes to #index" do
      get("/recommend/recommend_ptags").should route_to("recommend/recommend_ptags#index")
    end

    it "routes to #new" do
      get("/recommend/recommend_ptags/new").should route_to("recommend/recommend_ptags#new")
    end

    it "routes to #show" do
      get("/recommend/recommend_ptags/1").should route_to("recommend/recommend_ptags#show", :id => "1")
    end

    it "routes to #edit" do
      get("/recommend/recommend_ptags/1/edit").should route_to("recommend/recommend_ptags#edit", :id => "1")
    end

    it "routes to #create" do
      post("/recommend/recommend_ptags").should route_to("recommend/recommend_ptags#create")
    end

    it "routes to #update" do
      put("/recommend/recommend_ptags/1").should route_to("recommend/recommend_ptags#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/recommend/recommend_ptags/1").should route_to("recommend/recommend_ptags#destroy", :id => "1")
    end

  end
end
