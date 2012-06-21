require "spec_helper"

describe Recommend::RecommendUsersController do
  describe "routing" do

    it "routes to #index" do
      get("/recommend/recommend_users").should route_to("recommend/recommend_users#index")
    end

    it "routes to #new" do
      get("/recommend/recommend_users/new").should route_to("recommend/recommend_users#new")
    end

    it "routes to #show" do
      get("/recommend/recommend_users/1").should route_to("recommend/recommend_users#show", :id => "1")
    end

    it "routes to #edit" do
      get("/recommend/recommend_users/1/edit").should route_to("recommend/recommend_users#edit", :id => "1")
    end

    it "routes to #create" do
      post("/recommend/recommend_users").should route_to("recommend/recommend_users#create")
    end

    it "routes to #update" do
      put("/recommend/recommend_users/1").should route_to("recommend/recommend_users#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/recommend/recommend_users/1").should route_to("recommend/recommend_users#destroy", :id => "1")
    end

  end
end
