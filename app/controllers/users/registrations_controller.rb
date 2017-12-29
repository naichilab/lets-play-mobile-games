class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :authenticate_scope!, only: [:edit, :update, :destroy, :games]

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
    render :layout => 'user_profile_layout'
  end

  def games
    render :layout => 'user_profile_layout'
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
