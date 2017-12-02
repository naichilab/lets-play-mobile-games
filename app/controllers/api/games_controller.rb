module Api

  class GamesController < ApplicationController

    def index
      games = Game.all

      render json: games
    end

  end

end
