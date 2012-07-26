require 'spec_helper'

describe "subjects/show" do
  before(:each) do
    @subject = assign(:subject, stub_model(Subject,
      :title => "Title",
      :title2 => "Title2",
      :summary => "MyText",
      :content => "MyText",
      :body => "MyText",
      :category => 1,
      :sort_index => 2,
      :releated_ids => 3,
      :created_by => 4,
      :updated_by => 5,
      :deleted_by_id => 6
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Title2/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
    rendered.should match(/6/)
  end
end
