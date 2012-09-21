require 'spec_helper'

describe "work/user_statistics/show" do
  before(:each) do
    @work_user_statistic = assign(:work_user_statistic, stub_model(Work::UserStatistic))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
