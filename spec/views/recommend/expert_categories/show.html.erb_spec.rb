require 'spec_helper'

describe "recommend/expert_categories/show" do
  before(:each) do
    @recommend_expert_category = assign(:recommend_expert_category, stub_model(Recommend::ExpertCategory,
      :name => "Name",
      :sort_index => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
  end
end
