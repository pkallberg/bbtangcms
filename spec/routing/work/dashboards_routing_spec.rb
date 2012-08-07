require "spec_helper"

describe Work::DashboardsController do
  describe "routing" do

    it "routes to #index" do
      get("/work/dashboards").should route_to("work/dashboards#index")
    end

    it "routes to #new" do
      get("/work/dashboards/new").should route_to("work/dashboards#new")
    end

    it "routes to #show" do
      get("/work/dashboards/1").should route_to("work/dashboards#show", :id => "1")
    end

    it "routes to #edit" do
      get("/work/dashboards/1/edit").should route_to("work/dashboards#edit", :id => "1")
    end

    it "routes to #create" do
      post("/work/dashboards").should route_to("work/dashboards#create")
    end

    it "routes to #update" do
      put("/work/dashboards/1").should route_to("work/dashboards#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/work/dashboards/1").should route_to("work/dashboards#destroy", :id => "1")
    end

  end
end
