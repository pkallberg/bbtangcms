require 'spec_helper'

describe "Recommend::OtherColumns" do
  describe "GET /recommend_other_columns" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get recommend_other_columns_path
      response.status.should be(200)
    end
  end
end