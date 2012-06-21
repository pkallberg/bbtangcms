require 'spec_helper'

describe "recommend/recommend_events/new" do
  before(:each) do
    assign(:recommend_recommend_event, stub_model(Recommend::RecommendEvent,
      :position => "MyString",
      :name => "MyString",
      :body => "MyText"
    ).as_new_record)
  end

  it "renders new recommend_recommend_event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recommend_recommend_events_path, :method => "post" do
      assert_select "input#recommend_recommend_event_position", :name => "recommend_recommend_event[position]"
      assert_select "input#recommend_recommend_event_name", :name => "recommend_recommend_event[name]"
      assert_select "textarea#recommend_recommend_event_body", :name => "recommend_recommend_event[body]"
    end
  end
end
