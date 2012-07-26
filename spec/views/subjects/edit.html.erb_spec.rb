require 'spec_helper'

describe "subjects/edit" do
  before(:each) do
    @subject = assign(:subject, stub_model(Subject,
      :title => "MyString",
      :title2 => "MyString",
      :summary => "MyText",
      :content => "MyText",
      :body => "MyText",
      :category => 1,
      :sort_index => 1,
      :releated_ids => 1,
      :created_by => 1,
      :updated_by => 1,
      :deleted_by_id => 1
    ))
  end

  it "renders the edit subject form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => subjects_path(@subject), :method => "post" do
      assert_select "input#subject_title", :name => "subject[title]"
      assert_select "input#subject_title2", :name => "subject[title2]"
      assert_select "textarea#subject_summary", :name => "subject[summary]"
      assert_select "textarea#subject_content", :name => "subject[content]"
      assert_select "textarea#subject_body", :name => "subject[body]"
      assert_select "input#subject_category", :name => "subject[category]"
      assert_select "input#subject_sort_index", :name => "subject[sort_index]"
      assert_select "input#subject_releated_ids", :name => "subject[releated_ids]"
      assert_select "input#subject_created_by", :name => "subject[created_by]"
      assert_select "input#subject_updated_by", :name => "subject[updated_by]"
      assert_select "input#subject_deleted_by_id", :name => "subject[deleted_by_id]"
    end
  end
end
