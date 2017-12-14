require 'rails_helper'

RSpec.describe "store_urls/show", type: :view do
  before(:each) do
    @store_url = assign(:store_url, StoreUrl.create!(
      :game => nil,
      :platform => nil,
      :url => "Url",
      :memo => "Memo"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/Memo/)
  end
end
