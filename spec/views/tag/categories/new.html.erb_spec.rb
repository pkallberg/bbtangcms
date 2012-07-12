require 'spec_helper'

describe "tag/categories/new" do
  before(:each) do
    assign(:tag_category, stub_model(Tag::Category,
      :name => "MyString",
      :parent_id => 1
    ).as_new_record)
  end

  it "renders new tag_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tag_categories_path, :method => "post" do
      assert_select "input#tag_category_name", :name => "tag_category[name]"
      assert_select "input#tag_category_parent_id", :name => "tag_category[parent_id]"
    end
  end
end
