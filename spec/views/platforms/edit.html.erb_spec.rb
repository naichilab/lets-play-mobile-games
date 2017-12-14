require 'rails_helper'

RSpec.describe "platforms/edit", type: :view do
  before(:each) do
    @platform = assign(:platform, Platform.create!(
      :code => "MyString",
      :name => "MyString"
    ))
  end

  it "renders the edit platform form" do
    render

    assert_select "form[action=?][method=?]", platform_path(@platform), "post" do

      assert_select "input[name=?]", "platform[code]"

      assert_select "input[name=?]", "platform[name]"
    end
  end
end
