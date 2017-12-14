require 'rails_helper'

RSpec.describe "store_urls/new", type: :view do
  before(:each) do
    assign(:store_url, StoreUrl.new(
      :game => nil,
      :platform => nil,
      :url => "MyString",
      :memo => "MyString"
    ))
  end

  it "renders new store_url form" do
    render

    assert_select "form[action=?][method=?]", store_urls_path, "post" do

      assert_select "input[name=?]", "store_url[game_id]"

      assert_select "input[name=?]", "store_url[platform_id]"

      assert_select "input[name=?]", "store_url[url]"

      assert_select "input[name=?]", "store_url[memo]"
    end
  end
end
