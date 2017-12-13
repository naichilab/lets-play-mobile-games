require "rails_helper"

feature "Game Visit" do

  scenario "ゲーム一覧" do
    game1 = create(:game)
    game2 = create(:game)
    game3 = create(:game)

    # アクセスできること
    visit games_path

    expect(page).to have_link game1.title
    expect(page).to have_link game2.title
    expect(page).to have_link game3.title
  end


  scenario "ゲーム詳細" do
    game = create(:game)

    # アクセスできること
    visit game_path(id: game.id)
  end
end