require 'spec_helper'

describe "recommend/recommend_subjects/show" do
  before(:each) do
    @recommend_recommend_subject = assign(:recommend_recommend_subject, stub_model(Recommend::RecommendSubject,
      :position => "Position",
      :name => "Name",
      :body => "MyText",
      :ids => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Position/)
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
  end
end
