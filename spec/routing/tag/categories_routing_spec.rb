require "spec_helper"

describe Tag::CategoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/tag/categories").should route_to("tag/categories#index")
    end

    it "routes to #new" do
      get("/tag/categories/new").should route_to("tag/categories#new")
    end

    it "routes to #show" do
      get("/tag/categories/1").should route_to("tag/categories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tag/categories/1/edit").should route_to("tag/categories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tag/categories").should route_to("tag/categories#create")
    end

    it "routes to #update" do
      put("/tag/categories/1").should route_to("tag/categories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tag/categories/1").should route_to("tag/categories#destroy", :id => "1")
    end

  end
end
