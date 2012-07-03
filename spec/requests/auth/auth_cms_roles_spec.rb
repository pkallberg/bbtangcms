require 'spec_helper'

describe "Auth::CmsRoles" do
  describe "GET /auth_cms_roles" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get auth_cms_roles_path
      response.status.should be(200)
    end
  end
end
