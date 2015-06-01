class SessionsController < ApplicationController
  def destroy
    skip_authorization
    logout
    flash[:success] = t('user.messages.logged_out')
    redirect_to root_path
  end
end
