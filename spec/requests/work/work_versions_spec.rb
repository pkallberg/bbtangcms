require 'spec_helper'

describe "Work::Versions" do
  describe "GET /work_versions" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get work_versions_path
      response.status.should be(200)
    end
  end
end
