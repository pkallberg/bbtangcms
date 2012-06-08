require 'spec_helper'

describe "knowledges/edit" do
  before(:each) do
    @knowledge = assign(:knowledge, stub_model(Knowledge))
  end

  it "renders the edit knowledge form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => knowledges_path(@knowledge), :method => "post" do
    end
  end
end
