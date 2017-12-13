require "rails_helper"

feature "Game更新" do

  background do
    create(:category, name: 'シューティング')
    cat = create(:category, name: 'アクション')
    create(:category, name: 'アドベンチャー')

    user = build(:user)
    user.skip_confirmation!
    user.save
    sign_in user

    @game = create(:game, category: cat, user: user)
  end

  scenario "ゲームを更新" do
    visit game_path(@game)

    click_link '編集'

    fill_in 'タイトル', with: '新タイトル。'
    select "アドベンチャー", from: "game_category"
    fill_in 'AndroidストアURL', with: 'https://google.com/newandroid'
    fill_in 'iOSストアURL', with: 'https://google.com/newios'
    fill_in 'ガイドライン', with: "新ガイドライン"
    fill_in '実況者へ伝えたいこと', with: '伝えたいこと'

    click_button '更新'

    expect(page).to have_text '新タイトル'
    expect(page).to have_text 'アドベンチャー'
    #TODO 画像リンクのテスト方法わからない
    # expect(page).to have_link 'https://google.com/hogehoge'
    # expect(page).to have_link 'https://google.com/fugafuga'
    expect(page).to have_text '新ガイドライン'
    expect(page).to have_text '伝えたいこと'
  end

end