module Api

  class GamesController < ApplicationController

    def index
      games = Game.select(:id, :title, :icon, :permission)

      render json: games
    end

  end

end
