require "spec_helper"

describe Recommend::RecommendQuizzesController do
  describe "routing" do

    it "routes to #index" do
      get("/recommend/recommend_quizzes").should route_to("recommend/recommend_quizzes#index")
    end

    it "routes to #new" do
      get("/recommend/recommend_quizzes/new").should route_to("recommend/recommend_quizzes#new")
    end

    it "routes to #show" do
      get("/recommend/recommend_quizzes/1").should route_to("recommend/recommend_quizzes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/recommend/recommend_quizzes/1/edit").should route_to("recommend/recommend_quizzes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/recommend/recommend_quizzes").should route_to("recommend/recommend_quizzes#create")
    end

    it "routes to #update" do
      put("/recommend/recommend_quizzes/1").should route_to("recommend/recommend_quizzes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/recommend/recommend_quizzes/1").should route_to("recommend/recommend_quizzes#destroy", :id => "1")
    end

  end
end
