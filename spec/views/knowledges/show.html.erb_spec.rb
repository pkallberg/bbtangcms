require 'spec_helper'

describe "knowledges/show" do
  before(:each) do
    @knowledge = assign(:knowledge, stub_model(Knowledge))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
