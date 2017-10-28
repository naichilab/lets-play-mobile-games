class Users::RegistrationsController < Devise::RegistrationsController
  def cancel
    super
  end

  def create
    super
  end

  def new
    super
  end

  def edit
    super
  end

  def update
    # OAuthで登録したユーザーだとパスワードチェック通せない

    super
  end

  def destroy
    super
  end
end