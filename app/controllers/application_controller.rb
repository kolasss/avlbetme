class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_action :verify_authorized

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

    def user_not_authorized
      flash[:alert] = "Доступ запрещен."
      redirect_to(request.referrer || root_path)
    end

    def not_authenticated
      redirect_to auth_at_provider_path(:provider => :vk)
    end
end
