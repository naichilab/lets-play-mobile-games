require 'rails_helper'

describe Game do
  describe "ファクトリ" do
    it "通常ゲーム" do
      game = build(:game)
      expect(game).to be_valid
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
  end

end
