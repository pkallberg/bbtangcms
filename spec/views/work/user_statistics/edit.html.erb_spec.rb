require 'spec_helper'

describe "work/user_statistics/edit" do
  before(:each) do
    @work_user_statistic = assign(:work_user_statistic, stub_model(Work::UserStatistic))
  end

  it "renders the edit work_user_statistic form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => work_user_statistics_path(@work_user_statistic), :method => "post" do
    end
  end
end
