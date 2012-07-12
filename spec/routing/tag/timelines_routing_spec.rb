require "spec_helper"

describe Tag::TimelinesController do
  describe "routing" do

    it "routes to #index" do
      get("/tag/timelines").should route_to("tag/timelines#index")
    end

    it "routes to #new" do
      get("/tag/timelines/new").should route_to("tag/timelines#new")
    end

    it "routes to #show" do
      get("/tag/timelines/1").should route_to("tag/timelines#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tag/timelines/1/edit").should route_to("tag/timelines#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tag/timelines").should route_to("tag/timelines#create")
    end

    it "routes to #update" do
      put("/tag/timelines/1").should route_to("tag/timelines#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tag/timelines/1").should route_to("tag/timelines#destroy", :id => "1")
    end

  end
end
