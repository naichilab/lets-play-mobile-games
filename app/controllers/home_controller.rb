class HomeController < ApplicationController
  def index
    @game_count = Game.count
    render :layout => 'fullscreen'
 end
end
