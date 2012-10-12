require 'spec_helper'

describe SiteController do

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
  end

  describe "GET 'changelog'" do
    it "returns http success" do
      get 'changelog'
      response.should be_success
    end
  end

  describe "GET 'license'" do
    it "returns http success" do
      get 'license'
      response.should be_success
    end
  end

  describe "GET 'policies'" do
    it "returns http success" do
      get 'policies'
      response.should be_success
    end
  end

  describe "GET 'team'" do
    it "returns http success" do
      get 'team'
      response.should be_success
    end
  end

  describe "GET 'support'" do
    it "returns http success" do
      get 'support'
      response.should be_success
    end
  end

end
