class HomeController < ApplicationController
  def index
    @game_count = Game.count
  end
end
