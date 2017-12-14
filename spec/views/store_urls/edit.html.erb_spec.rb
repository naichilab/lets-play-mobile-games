require 'rails_helper'

RSpec.describe "store_urls/edit", type: :view do
  before(:each) do
    @store_url = assign(:store_url, StoreUrl.create!(
      :game => nil,
      :platform => nil,
      :url => "MyString",
      :memo => "MyString"
    ))
  end

  it "renders the edit store_url form" do
    render

    assert_select "form[action=?][method=?]", store_url_path(@store_url), "post" do

      assert_select "input[name=?]", "store_url[game_id]"

      assert_select "input[name=?]", "store_url[platform_id]"

      assert_select "input[name=?]", "store_url[url]"

      assert_select "input[name=?]", "store_url[memo]"
    end
  end
end
