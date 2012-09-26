require "spec_helper"

describe QuizCenter::QuizCollectionsController do
  describe "routing" do

    it "routes to #index" do
      get("/quiz_center/quiz_collections").should route_to("quiz_center/quiz_collections#index")
    end

    it "routes to #new" do
      get("/quiz_center/quiz_collections/new").should route_to("quiz_center/quiz_collections#new")
    end

    it "routes to #show" do
      get("/quiz_center/quiz_collections/1").should route_to("quiz_center/quiz_collections#show", :id => "1")
    end

    it "routes to #edit" do
      get("/quiz_center/quiz_collections/1/edit").should route_to("quiz_center/quiz_collections#edit", :id => "1")
    end

    it "routes to #create" do
      post("/quiz_center/quiz_collections").should route_to("quiz_center/quiz_collections#create")
    end

    it "routes to #update" do
      put("/quiz_center/quiz_collections/1").should route_to("quiz_center/quiz_collections#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/quiz_center/quiz_collections/1").should route_to("quiz_center/quiz_collections#destroy", :id => "1")
    end

  end
end
