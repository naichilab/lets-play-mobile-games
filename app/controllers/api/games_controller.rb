module Api

  class GamesController < ApplicationController

    def index
      pp params

      games = Game.all

      # TODO 単語検索の拡張
      # * スペースもしくはカンマがある場合は、それぞれに大してAND(絞り込み)検索としたい
      # * 検索対象はタイトルだけでなく、説明文(まだない)も対象としたい
      if params[:words].present?
        q = Game.arel_table[:title].matches("%#{params[:words]}%")
        games = games.where(q)
      end

      if params[:category].present?
        games = games.where(category_id: params[:category])
      end

      if params[:platform].present?
        if params[:platform]=='android'
          games = games.has_android
        end
        if params[:platform]=='ios'
          games = games.has_ios
        end
      end

      render json: games.shuffle
    end

  end

end
