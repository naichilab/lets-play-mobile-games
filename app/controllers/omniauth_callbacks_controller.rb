class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    @user = call(request.env["omniauth.auth"])
    # @user = User.from_omniauth(request.env["omniauth.auth"].except("extra"))

    if @user.persisted?
      sign_in_and_redirect @user
    else
      session["devise.user_attributes"] = @user.attributes
      redirect_to new_user_registration_url
    end
  end

  private

  def call(auth)
    # 認証データに対応するSocialProfileが存在するか確認し、なければSocialProfileを新規作成。
    # 認証データをSocialProfileオブジェクトにセットし、データベースに保存。
    profile = SocialProfile.find_for_oauth(auth)
    # ユーザーを探す。
    # 第１候補：ログイン中のユーザー、第２候補：SocialProfileオブジェクトに紐付けされているユーザー。
    user = current_or_profile_user(profile)
    unless user
      # 第３候補：認証データにemailが含まれていればそれを元にユーザーを探す。
      # 見つからなければ、ユーザーを新規作成。
      user ||= find_or_create_new_user(profile)
    end
    associate_user_with_profile!(user, profile)
    user
  end

  def current_or_profile_user(profile)
    user = current_user || profile.user
  end

  # 見つからなければ、ユーザーを新規作成。emailは後に確認するので今は仮のものを入れておく。
  # TEMP_EMAIL_PREFIXを手掛かりに後に仮のものかどうかの判別が可能。
  # OmniAuth認証時はパスワード入力は免除するので、ランダムのパスワードを入れておく。
  def find_or_create_new_user(profile)
    user = User.where(email: profile.email).first if profile.email
    if user.nil?
      rand_text = ((0..9).to_a + ("a".."z").to_a).sample(20).join
      temp_email = "#{User::TEMP_EMAIL_PREFIX}-#{rand_text}.com"
      temp_email = profile.email if profile.email

      user = User.new(
          username: profile.name,
          email: profile.email.present? ? profile.email: temp_email,
          password: User.new_token
      )

      # email確認メール送信を延期するために一時的にemail確認済みの状態にする。
      user.skip_confirmation!
      # 仮のemailをデータベースに保存するため、validationを一時的に無効化して保存
      user.save(validate: false)
    end
    user
  end

  # ユーザーとSocialProfileオブジェクトを関連づける。
  def associate_user_with_profile!(user, profile)
    profile.update!(user_id: user.id) if profile.user != user
  end

end
