require 'rails_helper'

describe Category do
  describe "ファクトリ" do
    context "正常なデータ" do
      let(:category) {build(:category)}
      subject {category}
      it {is_expected.to be_valid}
    end
    context "異常なデータ" do
      let(:invalid_category) {build(:invalid_category)}
      subject {invalid_category}
      it {is_expected.not_to be_valid}
    end
  end

  describe "バリデーション" do
    describe ":name" do
      let(:category) {build(:category, name: name)}
      subject {category}

      context "空白の場合" do
        let(:name) {"    "}
        it {is_expected.not_to be_valid}
      end

      context "33文字以上の場合" do
        let(:name) {"a" * 33}
        it {is_expected.not_to be_valid}
      end
    end
  end

end
