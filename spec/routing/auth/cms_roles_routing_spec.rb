require "spec_helper"

describe Auth::CmsRolesController do
  describe "routing" do

    it "routes to #index" do
      get("/auth/cms_roles").should route_to("auth/cms_roles#index")
    end

    it "routes to #new" do
      get("/auth/cms_roles/new").should route_to("auth/cms_roles#new")
    end

    it "routes to #show" do
      get("/auth/cms_roles/1").should route_to("auth/cms_roles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/auth/cms_roles/1/edit").should route_to("auth/cms_roles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/auth/cms_roles").should route_to("auth/cms_roles#create")
    end

    it "routes to #update" do
      put("/auth/cms_roles/1").should route_to("auth/cms_roles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/auth/cms_roles/1").should route_to("auth/cms_roles#destroy", :id => "1")
    end

  end
end
