require 'spec_helper'

describe "recommend/other_columns/edit" do
  before(:each) do
    @recommend_other_column = assign(:recommend_other_column, stub_model(Recommend::OtherColumn,
      :recommend_type => "MyString",
      :human_names => "",
      :column_names => ""
    ))
  end

  it "renders the edit recommend_other_column form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recommend_other_columns_path(@recommend_other_column), :method => "post" do
      assert_select "input#recommend_other_column_recommend_type", :name => "recommend_other_column[recommend_type]"
      assert_select "input#recommend_other_column_human_names", :name => "recommend_other_column[human_names]"
      assert_select "input#recommend_other_column_column_names", :name => "recommend_other_column[column_names]"
    end
  end
end
