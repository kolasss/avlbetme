class HomeController < ApplicationController
  def index
    skip_authorization
    @bets = Bet.all
  end
end
