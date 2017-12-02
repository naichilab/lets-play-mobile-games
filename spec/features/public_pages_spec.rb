require "rails_helper"

feature "Public pages" do

  scenario "ホームを表示" do
    visit root_path
    expect(page).to have_title "そのゲーム、実況できる？ - 実況OKなスマホゲームを集めました"
    # click_link 'ゲーム一覧'
    # expect(page).to have_title "登録ゲーム一覧 | そのゲーム、実況できる？ - 実況OKなスマホゲームを集めました"
  end

end