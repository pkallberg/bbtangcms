require "spec_helper"

describe Recommend::RecommendQuestionsController do
  describe "routing" do

    it "routes to #index" do
      get("/recommend/recommend_questions").should route_to("recommend/recommend_questions#index")
    end

    it "routes to #new" do
      get("/recommend/recommend_questions/new").should route_to("recommend/recommend_questions#new")
    end

    it "routes to #show" do
      get("/recommend/recommend_questions/1").should route_to("recommend/recommend_questions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/recommend/recommend_questions/1/edit").should route_to("recommend/recommend_questions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/recommend/recommend_questions").should route_to("recommend/recommend_questions#create")
    end

    it "routes to #update" do
      put("/recommend/recommend_questions/1").should route_to("recommend/recommend_questions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/recommend/recommend_questions/1").should route_to("recommend/recommend_questions#destroy", :id => "1")
    end

  end
end
