require 'spec_helper'

describe "knowledges/new" do
  before(:each) do
    assign(:knowledge, stub_model(Knowledge).as_new_record)
  end

  it "renders new knowledge form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => knowledges_path, :method => "post" do
    end
  end
end
