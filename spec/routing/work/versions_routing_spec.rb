require "spec_helper"

describe Work::VersionsController do
  describe "routing" do

    it "routes to #index" do
      get("/work/versions").should route_to("work/versions#index")
    end

    it "routes to #new" do
      get("/work/versions/new").should route_to("work/versions#new")
    end

    it "routes to #show" do
      get("/work/versions/1").should route_to("work/versions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/work/versions/1/edit").should route_to("work/versions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/work/versions").should route_to("work/versions#create")
    end

    it "routes to #update" do
      put("/work/versions/1").should route_to("work/versions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/work/versions/1").should route_to("work/versions#destroy", :id => "1")
    end

  end
end
