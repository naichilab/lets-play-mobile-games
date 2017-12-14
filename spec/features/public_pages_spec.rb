require "rails_helper"

feature "Public pages" do

  scenario "ホームを表示" do
    visit root_path
    expect(page).to have_title "ゲームを実況しよう！ - 実況OKなゲームを集めました"

    # header link 
    expect(page).to have_link "ゲームを実況しよう！"
  end

end