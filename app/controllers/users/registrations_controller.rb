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

  protected

  def update_resource(resource, params)
    if params[:password].present? || params[:password_confirmation].present? || params[:current_password] != nil
      resource.update_password_only(params)
    else
      resource.update_without_password(params)
    end
  end

end
