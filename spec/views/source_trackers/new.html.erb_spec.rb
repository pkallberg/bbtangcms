require 'spec_helper'

describe "source_trackers/new" do
  before(:each) do
    assign(:source_tracker, stub_model(SourceTracker,
      :key => "MyString",
      :platform => "MyString",
      :from => "MyString",
      :version_number => "MyString",
      :ip => "MyString",
      :url => "MyString"
    ).as_new_record)
  end

  it "renders new source_tracker form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => source_trackers_path, :method => "post" do
      assert_select "input#source_tracker_key", :name => "source_tracker[key]"
      assert_select "input#source_tracker_platform", :name => "source_tracker[platform]"
      assert_select "input#source_tracker_from", :name => "source_tracker[from]"
      assert_select "input#source_tracker_version_number", :name => "source_tracker[version_number]"
      assert_select "input#source_tracker_ip", :name => "source_tracker[ip]"
      assert_select "input#source_tracker_url", :name => "source_tracker[url]"
    end
  end
end
