require "spec_helper"

describe Work::ContactsController do
  describe "routing" do

    it "routes to #index" do
      get("/work/contacts").should route_to("work/contacts#index")
    end

    it "routes to #new" do
      get("/work/contacts/new").should route_to("work/contacts#new")
    end

    it "routes to #show" do
      get("/work/contacts/1").should route_to("work/contacts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/work/contacts/1/edit").should route_to("work/contacts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/work/contacts").should route_to("work/contacts#create")
    end

    it "routes to #update" do
      put("/work/contacts/1").should route_to("work/contacts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/work/contacts/1").should route_to("work/contacts#destroy", :id => "1")
    end

  end
end
