require 'spec_helper'

describe "recommend/expert_categories/edit" do
  before(:each) do
    @recommend_expert_category = assign(:recommend_expert_category, stub_model(Recommend::ExpertCategory,
      :name => "MyString",
      :sort_index => 1
    ))
  end

  it "renders the edit recommend_expert_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recommend_expert_categories_path(@recommend_expert_category), :method => "post" do
      assert_select "input#recommend_expert_category_name", :name => "recommend_expert_category[name]"
      assert_select "input#recommend_expert_category_sort_index", :name => "recommend_expert_category[sort_index]"
    end
  end
end