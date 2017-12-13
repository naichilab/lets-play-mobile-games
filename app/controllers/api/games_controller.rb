module Api

  class GamesController < ApplicationController

    def index

      pp params
      games = Game.select(:id, :title, :icon, :permission, :android_url, :ios_url)

      # unless params[:permission].blank?
      #   p = params[:permission] == "true"
      #   games = games.where(permission: p)
      # end

      unless params[:category].blank?
        games = games.where(category_id: params[:category])
      end

      unless params[:platform].blank?
        if params[:platform]=='android'
          games = games.where("android_url <> ''")
        end
        if params[:platform]=='ios'
          games = games.where("ios_url <> ''")
        end
      end

      render json: games.shuffle
    end

  end

end
