require "rails_helper"

feature "Game Registeration" do

  background do
    user = build(:user)
    user.skip_confirmation!
    user.save
    sign_in user
  end

  scenario "ゲームを登録" do
    visit root_path
    click_link 'ゲームを登録'
    expect(page).to have_text "新規登録"

    fill_in 'タイトル', with: 'これはゲームタイトルです。'
    select "シューティング", from: "game_category"
    check "game_permission"
    fill_in '条件・要望', with: 'ダウンロードページへのリンクを貼ってね！！！'
    fill_in 'AndroidストアURL', with: 'https://google.com/hogehoge'
    fill_in 'iOSストアURL', with: 'https://google.com/fugafuga'

    click_button '作成'

    expect(page).to have_text 'これはゲームタイトルです'
  end
end