require 'rails_helper'

RSpec.describe "store_urls/index", type: :view do
  before(:each) do
    assign(:store_urls, [
      StoreUrl.create!(
        :game => nil,
        :platform => nil,
        :url => "Url",
        :memo => "Memo"
      ),
      StoreUrl.create!(
        :game => nil,
        :platform => nil,
        :url => "Url",
        :memo => "Memo"
      )
    ])
  end

  it "renders a list of store_urls" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "Memo".to_s, :count => 2
  end
end
