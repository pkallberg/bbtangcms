require 'spec_helper'

describe "recommend/recommend_events/edit" do
  before(:each) do
    @recommend_recommend_event = assign(:recommend_recommend_event, stub_model(Recommend::RecommendEvent,
      :position => "MyString",
      :name => "MyString",
      :body => "MyText"
    ))
  end

  it "renders the edit recommend_recommend_event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recommend_recommend_events_path(@recommend_recommend_event), :method => "post" do
      assert_select "input#recommend_recommend_event_position", :name => "recommend_recommend_event[position]"
      assert_select "input#recommend_recommend_event_name", :name => "recommend_recommend_event[name]"
      assert_select "textarea#recommend_recommend_event_body", :name => "recommend_recommend_event[body]"
    end
  end
end
