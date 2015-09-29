class HomeController < ApplicationController
  def index
    skip_authorization
    @bets = Bet.all.by_created.page params[:page]

    @friends_activities = current_user.friends_activities.limit(30) if logged_in?
  end
end
