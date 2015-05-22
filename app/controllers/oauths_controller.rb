class OauthsController < ApplicationController
  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]

    # p request.env
    # p '===================='
    if @user = login_from(provider, true)
      redirect_to root_path, :notice => "Logged in from #{provider.titleize}!"
    else
      begin
        p request.env
        p '===================='
        @user = create_from(provider)

        reset_session # protect from session fixation attack
        # auto_login(@user)
        auto_login(@user, true)
        redirect_to root_path, :notice => "Logged in from #{provider.titleize}!"
      rescue
        redirect_to root_path, :alert => "Failed to login from #{provider.titleize}!"
      end
    end
  end

  #example for Rails 4: add private method below and use "auth_params[:provider]" in place of
  #"params[:provider] above.

  private
    def auth_params
      params.permit(:code, :provider)
    end
end
