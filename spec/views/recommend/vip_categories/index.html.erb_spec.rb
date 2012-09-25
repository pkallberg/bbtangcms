require 'spec_helper'

describe "recommend/vip_categories/index" do
  before(:each) do
    assign(:recommend_vip_categories, [
      stub_model(Recommend::VipCategory,
        :name => "Name",
        :sort_index => 1
      ),
      stub_model(Recommend::VipCategory,
        :name => "Name",
        :sort_index => 1
      )
    ])
  end

  it "renders a list of recommend/vip_categories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
