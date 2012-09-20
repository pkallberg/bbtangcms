require 'spec_helper'

describe "recommend/other_columns/show" do
  before(:each) do
    @recommend_other_column = assign(:recommend_other_column, stub_model(Recommend::OtherColumn,
      :recommend_type => "Recommend Type",
      :human_names => "",
      :column_names => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Recommend Type/)
    rendered.should match(//)
    rendered.should match(//)
  end
end
