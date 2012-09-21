require 'spec_helper'

describe "work/user_statistics/index" do
  before(:each) do
    assign(:work_user_statistics, [
      stub_model(Work::UserStatistic),
      stub_model(Work::UserStatistic)
    ])
  end

  it "renders a list of work/user_statistics" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
