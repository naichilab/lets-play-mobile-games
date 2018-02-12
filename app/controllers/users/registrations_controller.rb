class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :authenticate_scope!, only: [:edit, :games, :update, :destroy]
  layout 'user_profile_layout', only: [:edit, :games, :update]

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
  end

  def games
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

  def after_update_path_for(resource)
    edit_user_registration_path
  end

end
