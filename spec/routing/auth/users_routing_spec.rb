require "spec_helper"

describe Auth::UsersController do
  describe "routing" do

    it "routes to #index" do
      get("/auth/users").should route_to("auth/users#index")
    end

    it "routes to #new" do
      get("/auth/users/new").should route_to("auth/users#new")
    end

    it "routes to #show" do
      get("/auth/users/1").should route_to("auth/users#show", :id => "1")
    end

    it "routes to #edit" do
      get("/auth/users/1/edit").should route_to("auth/users#edit", :id => "1")
    end

    it "routes to #create" do
      post("/auth/users").should route_to("auth/users#create")
    end

    it "routes to #update" do
      put("/auth/users/1").should route_to("auth/users#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/auth/users/1").should route_to("auth/users#destroy", :id => "1")
    end

  end
end
