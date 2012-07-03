require 'spec_helper'

describe "Auth::AssignPermits" do
  describe "GET /auth_assign_permits" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get auth_assign_permits_path
      response.status.should be(200)
    end
  end
end
