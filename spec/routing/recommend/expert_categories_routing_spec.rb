require "spec_helper"

describe Recommend::ExpertCategoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/recommend/expert_categories").should route_to("recommend/expert_categories#index")
    end

    it "routes to #new" do
      get("/recommend/expert_categories/new").should route_to("recommend/expert_categories#new")
    end

    it "routes to #show" do
      get("/recommend/expert_categories/1").should route_to("recommend/expert_categories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/recommend/expert_categories/1/edit").should route_to("recommend/expert_categories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/recommend/expert_categories").should route_to("recommend/expert_categories#create")
    end

    it "routes to #update" do
      put("/recommend/expert_categories/1").should route_to("recommend/expert_categories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/recommend/expert_categories/1").should route_to("recommend/expert_categories#destroy", :id => "1")
    end

  end
end
