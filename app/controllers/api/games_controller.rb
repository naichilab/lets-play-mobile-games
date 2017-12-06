module Api

  class GamesController < ApplicationController

    def index

      pp params
      games = Game.select(:id, :title, :icon, :permission, :android_url, :ios_url)

      unless params[:permission].blank?
        p = params[:permission] == "true"
        games = games.where(permission: p)
      end


      unless params[:categories].blank?
        category_ids = params[:categories]
        games = games.where(category_id: category_ids)
      end

      unless params[:platforms].blank?
        if params[:platforms].to_a.include?('android')
          games = games.where("android_url <> ''")
        end
        if params[:platforms].to_a.include?('ios')
          games = games.where("ios_url <> ''")
        end
      end

      render json: games.shuffle
    end

  end

end
