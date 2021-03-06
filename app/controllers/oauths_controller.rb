class OauthsController < ApplicationController
  def oauth
    skip_authorization
    login_at(auth_params[:provider])
  end

  def callback
    skip_authorization
    provider = auth_params[:provider]

    if @user = login_from(provider, true)
      redirect_successful_auth provider
    else
      begin
        @user = create_from(provider)
        @user.get_friends_from_vk

        reset_session # protect from session fixation attack
        auto_login(@user, true)
        redirect_successful_auth provider
      rescue
        redirect_to root_path, alert: t('user.messages.cant_login', provider: provider.titleize )
      end
    end
  end

  private

    def auth_params
      params.permit(:code, :provider)
    end

    def redirect_successful_auth provider
      redirect_back_or_to user_path(current_user), notice: t('user.messages.logged_in', provider: provider.titleize )
    end
end
