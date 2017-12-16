require 'rails_helper'

describe Game do
  describe "ファクトリ" do
    it "通常ゲーム" do
      game = build(:game)
      expect(game).to be_valid
    end
    it "無効なゲーム" do
      game = build(:invalid_game)
      expect(game).not_to be_valid
    end
  end

  describe "バリデーション" do
    describe ":title" do
      let(:game) {build(:game, title: title)}
      subject {game}

      context "空白の場合" do
        let(:title) {"    "}
        it {is_expected.not_to be_valid}
      end

      context "65文字以上の場合" do
        let(:title) {"a" * 65}
        it {is_expected.not_to be_valid}
      end
    end

    describe ":guideline" do
      let(:game) {build(:game, guideline: guideline)}
      subject {game}

      context "513文字以上の場合" do
        let(:guideline) {"a" * 513}
        it {is_expected.not_to be_valid}
      end
    end
  end

  describe "scopes" do
    describe 'has_android' do
      before do
        @game1 = create(:game, android_url: nil)
        @game2 = create(:game, android_url: 'https://hoge.com/')
        @game3 = create(:game, android_url: '')
        @game4 = create(:game, android_url: 'https://fuga.com/')
      end
      subject {Game.has_android.pluck(:id)}
      it {is_expected.to contain_exactly @game2.id, @game4.id}
    end
    describe 'has_ios' do
      before do
        @game1 = create(:game, ios_url: nil)
        @game2 = create(:game, ios_url: 'https://hoge.com/')
        @game3 = create(:game, ios_url: '')
        @game4 = create(:game, ios_url: 'https://fuga.com/')
      end
      subject {Game.has_ios.pluck(:id)}
      it {is_expected.to contain_exactly @game2.id, @game4.id}
    end

  end


end
