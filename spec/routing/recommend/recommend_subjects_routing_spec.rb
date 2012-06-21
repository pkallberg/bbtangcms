require "spec_helper"

describe Recommend::RecommendSubjectsController do
  describe "routing" do

    it "routes to #index" do
      get("/recommend/recommend_subjects").should route_to("recommend/recommend_subjects#index")
    end

    it "routes to #new" do
      get("/recommend/recommend_subjects/new").should route_to("recommend/recommend_subjects#new")
    end

    it "routes to #show" do
      get("/recommend/recommend_subjects/1").should route_to("recommend/recommend_subjects#show", :id => "1")
    end

    it "routes to #edit" do
      get("/recommend/recommend_subjects/1/edit").should route_to("recommend/recommend_subjects#edit", :id => "1")
    end

    it "routes to #create" do
      post("/recommend/recommend_subjects").should route_to("recommend/recommend_subjects#create")
    end

    it "routes to #update" do
      put("/recommend/recommend_subjects/1").should route_to("recommend/recommend_subjects#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/recommend/recommend_subjects/1").should route_to("recommend/recommend_subjects#destroy", :id => "1")
    end

  end
end
