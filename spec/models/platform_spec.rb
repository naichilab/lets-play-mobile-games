require 'rails_helper'

describe Platform do
  describe "ファクトリ" do
    context "正常なデータ" do
      let(:platform) {build(:platform)}
      subject {platform}
      it {is_expected.to be_valid}
    end
    context "異常なデータ" do
      let(:invalid_platform) {build(:invalid_platform)}
      subject {invalid_platform}
      it {is_expected.not_to be_valid}
    end
  end
  describe "バリデーション" do
    describe ":code" do
      let(:platform) {build(:platform, code: code)}
      subject {platform}

      context "空白の場合" do
        let(:code) {"  "}
        it {is_expected.not_to be_valid}
      end
      context "17文字以上の場合" do
        let(:code) {"a" * 17}
        it {is_expected.not_to be_valid}
      end
    end
    describe ":name" do
      let(:platform) {build(:platform, name: name)}
      subject {platform}

      context "空白の場合" do
        let(:name) {"  "}
        it {is_expected.not_to be_valid}
      end
      context "33文字以上の場合" do
        let(:name) {"a" * 33}
        it {is_expected.not_to be_valid}
      end
    end
  end
end
