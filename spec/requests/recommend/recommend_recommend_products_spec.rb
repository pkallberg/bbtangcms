require 'spec_helper'

describe "Recommend::RecommendProducts" do
  describe "GET /recommend_recommend_products" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get recommend_recommend_products_path
      response.status.should be(200)
    end
  end
end
