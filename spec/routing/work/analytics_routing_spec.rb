require "spec_helper"

describe Work::AnalyticsController do
  describe "routing" do

    it "routes to #index" do
      get("/work/analytics").should route_to("work/analytics#index")
    end

    it "routes to #new" do
      get("/work/analytics/new").should route_to("work/analytics#new")
    end

    it "routes to #show" do
      get("/work/analytics/1").should route_to("work/analytics#show", :id => "1")
    end

    it "routes to #edit" do
      get("/work/analytics/1/edit").should route_to("work/analytics#edit", :id => "1")
    end

    it "routes to #create" do
      post("/work/analytics").should route_to("work/analytics#create")
    end

    it "routes to #update" do
      put("/work/analytics/1").should route_to("work/analytics#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/work/analytics/1").should route_to("work/analytics#destroy", :id => "1")
    end

  end
end
