require 'spec_helper'

describe "recommend/other_columns/index" do
  before(:each) do
    assign(:recommend_other_columns, [
      stub_model(Recommend::OtherColumn,
        :recommend_type => "Recommend Type",
        :human_names => "",
        :column_names => ""
      ),
      stub_model(Recommend::OtherColumn,
        :recommend_type => "Recommend Type",
        :human_names => "",
        :column_names => ""
      )
    ])
  end

  it "renders a list of recommend/other_columns" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Recommend Type".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
