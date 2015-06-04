class HomeController < ApplicationController
  def index
    skip_authorization
    @bets = Bet.all.by_created.page params[:page]
  end
end
