require "rails_helper"

feature "Game Registeration" do

  background do
    create(:category, name: 'シューティング')
    create(:category, name: 'アクション')
    create(:category, name: 'アドベンチャー')

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
    fill_in '条件・要望', with: 'ダウンロードページへのリンクを貼ってね！！！'
    fill_in 'AndroidストアURL', with: 'https://google.com/hogehoge'
    fill_in 'iOSストアURL', with: 'https://google.com/fugafuga'

    click_button '作成'

    expect(page).to have_text 'これはゲームタイトルです'
  end

  scenario "ゲーム一覧" do
    create(:game)
    create(:game)
    create(:game)
    create(:game)
    create(:game)

    # アクセスできること
    visit games_path
  end

  scenario "ゲーム詳細" do
    game = create(:game)

    # アクセスできること
    visit game_path(id: game.id)
  end
end