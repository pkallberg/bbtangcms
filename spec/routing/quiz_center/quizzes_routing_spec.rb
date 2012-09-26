require "spec_helper"

describe QuizCenter::QuizzesController do
  describe "routing" do

    it "routes to #index" do
      get("/quiz_center/quizzes").should route_to("quiz_center/quizzes#index")
    end

    it "routes to #new" do
      get("/quiz_center/quizzes/new").should route_to("quiz_center/quizzes#new")
    end

    it "routes to #show" do
      get("/quiz_center/quizzes/1").should route_to("quiz_center/quizzes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/quiz_center/quizzes/1/edit").should route_to("quiz_center/quizzes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/quiz_center/quizzes").should route_to("quiz_center/quizzes#create")
    end

    it "routes to #update" do
      put("/quiz_center/quizzes/1").should route_to("quiz_center/quizzes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/quiz_center/quizzes/1").should route_to("quiz_center/quizzes#destroy", :id => "1")
    end

  end
end
