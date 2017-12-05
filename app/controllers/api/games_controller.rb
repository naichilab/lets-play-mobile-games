module Api

  class GamesController < ApplicationController

    def index

      pp params[:permission]
      pp params[:platforms]
      pp params[:categories]

      games = Game.select(:id, :title, :icon, :permission)

      render json: games
    end

  end

end
