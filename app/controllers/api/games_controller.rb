module Api

  class GamesController < ApplicationController

    def index

      games = Game.select(:id, :title, :permission)
      # games = Game.select(:id, :title, :icon, :permission)

      unless params[:categories].blank?
        name = params[:categories]
        pp name

        games = games.where(category_id: name)
      end

      # pp params[:permission]
      # pp params[:platforms]
      # pp params[:categories]


      render json: games
    end

  end

end
