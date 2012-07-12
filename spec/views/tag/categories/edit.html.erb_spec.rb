require 'spec_helper'

describe "tag/categories/edit" do
  before(:each) do
    @tag_category = assign(:tag_category, stub_model(Tag::Category,
      :name => "MyString",
      :parent_id => 1
    ))
  end

  it "renders the edit tag_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tag_categories_path(@tag_category), :method => "post" do
      assert_select "input#tag_category_name", :name => "tag_category[name]"
      assert_select "input#tag_category_parent_id", :name => "tag_category[parent_id]"
    end
  end
end
