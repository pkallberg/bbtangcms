require "spec_helper"

describe SourceTrackersController do
  describe "routing" do

    it "routes to #index" do
      get("/source_trackers").should route_to("source_trackers#index")
    end

    it "routes to #new" do
      get("/source_trackers/new").should route_to("source_trackers#new")
    end

    it "routes to #show" do
      get("/source_trackers/1").should route_to("source_trackers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/source_trackers/1/edit").should route_to("source_trackers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/source_trackers").should route_to("source_trackers#create")
    end

    it "routes to #update" do
      put("/source_trackers/1").should route_to("source_trackers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/source_trackers/1").should route_to("source_trackers#destroy", :id => "1")
    end

  end
end
