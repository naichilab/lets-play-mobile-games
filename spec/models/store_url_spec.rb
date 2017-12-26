require 'rails_helper'

describe StoreUrl do
  describe "ファクトリ" do
    context "正常なデータ" do
      let(:store_url) {build(:store_url)}
      subject {store_url}
      it {is_expected.to be_valid}
    end
    context "異常なデータ" do
      let(:invalid_store_url) {build(:invalid_store_url)}
      subject {invalid_store_url}
      it {is_expected.not_to be_valid}
    end
  end
  describe "バリデーション" do
    describe ":url" do
      let(:store_url) {build(:store_url, url: url)}
      subject {store_url}

      context "空白の場合" do
        let(:url) {"  "}
        it {is_expected.not_to be_valid}
      end
      context "257文字以上の場合" do
        let(:url) {"a" * 257}
        it {is_expected.not_to be_valid}
      end
    end
    describe ":memo" do
      let(:store_url) {build(:store_url, memo: memo)}
      subject {store_url}

      context "257文字以上の場合" do
        let(:memo) {"a" * 257}
        it {is_expected.not_to be_valid}
      end
    end
  end
end
