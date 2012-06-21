require "spec_helper"

describe Recommend::RecommendMtoolsController do
  describe "routing" do

    it "routes to #index" do
      get("/recommend/recommend_mtools").should route_to("recommend/recommend_mtools#index")
    end

    it "routes to #new" do
      get("/recommend/recommend_mtools/new").should route_to("recommend/recommend_mtools#new")
    end

    it "routes to #show" do
      get("/recommend/recommend_mtools/1").should route_to("recommend/recommend_mtools#show", :id => "1")
    end

    it "routes to #edit" do
      get("/recommend/recommend_mtools/1/edit").should route_to("recommend/recommend_mtools#edit", :id => "1")
    end

    it "routes to #create" do
      post("/recommend/recommend_mtools").should route_to("recommend/recommend_mtools#create")
    end

    it "routes to #update" do
      put("/recommend/recommend_mtools/1").should route_to("recommend/recommend_mtools#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/recommend/recommend_mtools/1").should route_to("recommend/recommend_mtools#destroy", :id => "1")
    end

  end
end
