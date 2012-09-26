require 'spec_helper'

describe "QuizCenter::QuizCollections" do
  describe "GET /quiz_center_quiz_collections" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get quiz_center_quiz_collections_path
      response.status.should be(200)
    end
  end
end
