require 'spec_helper'

describe "recommend/vip_categories/new" do
  before(:each) do
    assign(:recommend_vip_category, stub_model(Recommend::VipCategory,
      :name => "MyString",
      :sort_index => 1
    ).as_new_record)
  end

  it "renders new recommend_vip_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recommend_vip_categories_path, :method => "post" do
      assert_select "input#recommend_vip_category_name", :name => "recommend_vip_category[name]"
      assert_select "input#recommend_vip_category_sort_index", :name => "recommend_vip_category[sort_index]"
    end
  end
end
