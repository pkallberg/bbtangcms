require "spec_helper"

describe Recommend::OtherColumnsController do
  describe "routing" do

    it "routes to #index" do
      get("/recommend/other_columns").should route_to("recommend/other_columns#index")
    end

    it "routes to #new" do
      get("/recommend/other_columns/new").should route_to("recommend/other_columns#new")
    end

    it "routes to #show" do
      get("/recommend/other_columns/1").should route_to("recommend/other_columns#show", :id => "1")
    end

    it "routes to #edit" do
      get("/recommend/other_columns/1/edit").should route_to("recommend/other_columns#edit", :id => "1")
    end

    it "routes to #create" do
      post("/recommend/other_columns").should route_to("recommend/other_columns#create")
    end

    it "routes to #update" do
      put("/recommend/other_columns/1").should route_to("recommend/other_columns#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/recommend/other_columns/1").should route_to("recommend/other_columns#destroy", :id => "1")
    end

  end
end
