require "spec_helper"

describe Auth::AssignPermitsController do
  describe "routing" do

    it "routes to #index" do
      get("/auth/assign_permits").should route_to("auth/assign_permits#index")
    end

    it "routes to #new" do
      get("/auth/assign_permits/new").should route_to("auth/assign_permits#new")
    end

    it "routes to #show" do
      get("/auth/assign_permits/1").should route_to("auth/assign_permits#show", :id => "1")
    end

    it "routes to #edit" do
      get("/auth/assign_permits/1/edit").should route_to("auth/assign_permits#edit", :id => "1")
    end

    it "routes to #create" do
      post("/auth/assign_permits").should route_to("auth/assign_permits#create")
    end

    it "routes to #update" do
      put("/auth/assign_permits/1").should route_to("auth/assign_permits#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/auth/assign_permits/1").should route_to("auth/assign_permits#destroy", :id => "1")
    end

  end
end
