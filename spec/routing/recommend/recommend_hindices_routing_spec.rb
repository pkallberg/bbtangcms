require "spec_helper"

describe Recommend::RecommendHindicesController do
  describe "routing" do

    it "routes to #index" do
      get("/recommend/recommend_hindices").should route_to("recommend/recommend_hindices#index")
    end

    it "routes to #new" do
      get("/recommend/recommend_hindices/new").should route_to("recommend/recommend_hindices#new")
    end

    it "routes to #show" do
      get("/recommend/recommend_hindices/1").should route_to("recommend/recommend_hindices#show", :id => "1")
    end

    it "routes to #edit" do
      get("/recommend/recommend_hindices/1/edit").should route_to("recommend/recommend_hindices#edit", :id => "1")
    end

    it "routes to #create" do
      post("/recommend/recommend_hindices").should route_to("recommend/recommend_hindices#create")
    end

    it "routes to #update" do
      put("/recommend/recommend_hindices/1").should route_to("recommend/recommend_hindices#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/recommend/recommend_hindices/1").should route_to("recommend/recommend_hindices#destroy", :id => "1")
    end

  end
end
