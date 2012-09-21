require "spec_helper"

describe Work::UserStatisticsController do
  describe "routing" do

    it "routes to #index" do
      get("/work/user_statistics").should route_to("work/user_statistics#index")
    end

    it "routes to #new" do
      get("/work/user_statistics/new").should route_to("work/user_statistics#new")
    end

    it "routes to #show" do
      get("/work/user_statistics/1").should route_to("work/user_statistics#show", :id => "1")
    end

    it "routes to #edit" do
      get("/work/user_statistics/1/edit").should route_to("work/user_statistics#edit", :id => "1")
    end

    it "routes to #create" do
      post("/work/user_statistics").should route_to("work/user_statistics#create")
    end

    it "routes to #update" do
      put("/work/user_statistics/1").should route_to("work/user_statistics#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/work/user_statistics/1").should route_to("work/user_statistics#destroy", :id => "1")
    end

  end
end
