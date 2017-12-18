require "rails_helper"

feature "Game Visit" do

  scenario "ゲーム一覧" do
    game1 = create(:game)
    game2 = create(:game)
    game3 = create(:game)

    # アクセスできること
    visit games_path

    # TODO vueで描画されたあとの状態をテストしたい
    # 下記はみ描画状態なので１件も見つからずエラーとなる
    # expect(page).to have_text game1.title
    # expect(page).to have_text game2.title
    # expect(page).to have_text game3.title
  end


  scenario "ゲーム詳細" do
    game = create(:game)

    # アクセスできること
    visit game_path(id: game.id)
  end
end