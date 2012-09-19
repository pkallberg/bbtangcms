require 'spec_helper'

describe "recommend/expert_categories/new" do
  before(:each) do
    assign(:recommend_expert_category, stub_model(Recommend::ExpertCategory,
      :name => "MyString",
      :sort_index => 1
    ).as_new_record)
  end

  it "renders new recommend_expert_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recommend_expert_categories_path, :method => "post" do
      assert_select "input#recommend_expert_category_name", :name => "recommend_expert_category[name]"
      assert_select "input#recommend_expert_category_sort_index", :name => "recommend_expert_category[sort_index]"
    end
  end
end
