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
    click_link 'ゲームを登録', match: :first
    expect(page).to have_text "新規登録"

    fill_in 'タイトル', with: 'これはゲームタイトルです。'
    select "シューティング", from: "game_category"
    fill_in 'AndroidストアURL', with: 'https://google.com/hogehoge'
    fill_in 'iOSストアURL', with: 'https://google.com/fugafuga'
    fill_in 'ガイドライン', with: "ガイドラインはこちらです！！¥r¥nhttps://www.google.co.jp/search?q=ガイドライン"
    fill_in '実況者へ伝えたいこと', with: 'ダウンロードページへのリンクを貼ってね！！！'

    click_button '作成'

    expect(page).to have_text 'これはゲームタイトルです'
    expect(page).to have_text 'シューティング'
    #TODO 画像リンクのテスト方法わからない
    # expect(page).to have_link 'https://google.com/hogehoge'
    # expect(page).to have_link 'https://google.com/fugafuga'
    expect(page).to have_text 'ガイドラインはこちらです！！'
    expect(page).to have_text 'ダウンロードページへのリンクを貼ってね'
  end

end
