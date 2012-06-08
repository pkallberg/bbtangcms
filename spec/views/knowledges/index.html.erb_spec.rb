require 'spec_helper'

describe "knowledges/index" do
  before(:each) do
    assign(:knowledges, [
      stub_model(Knowledge),
      stub_model(Knowledge)
    ])
  end

  it "renders a list of knowledges" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
