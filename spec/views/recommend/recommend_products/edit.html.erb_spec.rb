require 'spec_helper'

describe "recommend/recommend_products/edit" do
  before(:each) do
    @recommend_recommend_product = assign(:recommend_recommend_product, stub_model(Recommend::RecommendProduct,
      :position => "MyString",
      :name => "MyString",
      :image => "MyString",
      :title => "MyString",
      :price => 1.5,
      :cnt_buy => 1,
      :cnt_comment => 1,
      :link_url => "MyString"
    ))
  end

  it "renders the edit recommend_recommend_product form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recommend_recommend_products_path(@recommend_recommend_product), :method => "post" do
      assert_select "input#recommend_recommend_product_position", :name => "recommend_recommend_product[position]"
      assert_select "input#recommend_recommend_product_name", :name => "recommend_recommend_product[name]"
      assert_select "input#recommend_recommend_product_image", :name => "recommend_recommend_product[image]"
      assert_select "input#recommend_recommend_product_title", :name => "recommend_recommend_product[title]"
      assert_select "input#recommend_recommend_product_price", :name => "recommend_recommend_product[price]"
      assert_select "input#recommend_recommend_product_cnt_buy", :name => "recommend_recommend_product[cnt_buy]"
      assert_select "input#recommend_recommend_product_cnt_comment", :name => "recommend_recommend_product[cnt_comment]"
      assert_select "input#recommend_recommend_product_link_url", :name => "recommend_recommend_product[link_url]"
    end
  end
end
