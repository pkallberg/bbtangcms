require "spec_helper"

describe Recommend::VipCategoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/recommend/vip_categories").should route_to("recommend/vip_categories#index")
    end

    it "routes to #new" do
      get("/recommend/vip_categories/new").should route_to("recommend/vip_categories#new")
    end

    it "routes to #show" do
      get("/recommend/vip_categories/1").should route_to("recommend/vip_categories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/recommend/vip_categories/1/edit").should route_to("recommend/vip_categories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/recommend/vip_categories").should route_to("recommend/vip_categories#create")
    end

    it "routes to #update" do
      put("/recommend/vip_categories/1").should route_to("recommend/vip_categories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/recommend/vip_categories/1").should route_to("recommend/vip_categories#destroy", :id => "1")
    end

  end
end
