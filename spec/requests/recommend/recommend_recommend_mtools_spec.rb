require 'spec_helper'

describe "Recommend::RecommendMtools" do
  describe "GET /recommend_recommend_mtools" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get recommend_recommend_mtools_path
      response.status.should be(200)
    end
  end
end
