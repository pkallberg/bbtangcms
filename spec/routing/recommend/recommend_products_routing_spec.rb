require "spec_helper"

describe Recommend::RecommendProductsController do
  describe "routing" do

    it "routes to #index" do
      get("/recommend/recommend_products").should route_to("recommend/recommend_products#index")
    end

    it "routes to #new" do
      get("/recommend/recommend_products/new").should route_to("recommend/recommend_products#new")
    end

    it "routes to #show" do
      get("/recommend/recommend_products/1").should route_to("recommend/recommend_products#show", :id => "1")
    end

    it "routes to #edit" do
      get("/recommend/recommend_products/1/edit").should route_to("recommend/recommend_products#edit", :id => "1")
    end

    it "routes to #create" do
      post("/recommend/recommend_products").should route_to("recommend/recommend_products#create")
    end

    it "routes to #update" do
      put("/recommend/recommend_products/1").should route_to("recommend/recommend_products#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/recommend/recommend_products/1").should route_to("recommend/recommend_products#destroy", :id => "1")
    end

  end
end
