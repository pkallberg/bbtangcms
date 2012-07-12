require "spec_helper"

describe Tag::IdentitiesController do
  describe "routing" do

    it "routes to #index" do
      get("/tag/identities").should route_to("tag/identities#index")
    end

    it "routes to #new" do
      get("/tag/identities/new").should route_to("tag/identities#new")
    end

    it "routes to #show" do
      get("/tag/identities/1").should route_to("tag/identities#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tag/identities/1/edit").should route_to("tag/identities#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tag/identities").should route_to("tag/identities#create")
    end

    it "routes to #update" do
      put("/tag/identities/1").should route_to("tag/identities#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tag/identities/1").should route_to("tag/identities#destroy", :id => "1")
    end

  end
end
