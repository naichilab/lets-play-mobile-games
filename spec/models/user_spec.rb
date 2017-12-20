require 'rails_helper'

describe User do
  describe "ファクトリ" do
    it "通常ユーザー" do
      user = build(:user)
      expect(user).to be_valid
      expect(user.admin).to be_falsey
    end
    it "管理者ユーザー" do
      admin_user = build(:admin_user)
      expect(admin_user).to be_valid
      expect(admin_user.admin).to be_truthy
    end
    it "無効なユーザー" do
      invalid_user = build(:invalid_user)
      expect(invalid_user).not_to be_valid
    end
  end

  describe "バリデーション" do
    describe ":username" do
      let(:user) {build(:user, username: username)}
      subject {user}

      context "空白の場合" do
        let(:username) {"    "}
        it {is_expected.not_to be_valid}
      end

      context "51文字以上の場合" do
        let(:username) {"a" * 51}
        it {is_expected.not_to be_valid}
      end
    end
  end

  describe "パスワードのみ更新" do
    let(:user) { build(:user) }
    subject { user.update_password_only(params) }
    let(:params) { HashWithIndifferentAccess.new }
    let(:valid_password) { user.password }

    context "現在のパスワードのみ正しい場合" do
      it "更新成功" do
        password_parameter = "testtest"
        params[:password] = password_parameter
        params[:password_confirmation] = password_parameter
        params[:current_password] = valid_password
        is_expected.to be_truthy
      end

      it "更新失敗" do
        params[:current_password] = valid_password
        is_expected.to be_falsey
      end
    end

    context "新しいパスワードのみ正しい場合" do
      it "更新失敗" do
        params[:password] = "testtest"
        params[:password_confirmation] = "testtest"
        is_expected.to be_falsey
      end
    end

    context "新しいパスワードに誤りがある場合" do
      it "更新失敗" do
        params[:password] = "validpassword"
        params[:password_confirmation] = "invalidpassword"
        params[:current_password] = valid_password
        is_expected.to be_falsey
      end
    end
  end
end
