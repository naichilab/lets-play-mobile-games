module Api

  class GamesController < ApplicationController
    before_action :set_platforms

    def index

      pp params

      @games = Game.eager_load(:platforms)

      # TODO 単語検索の拡張
      # * スペースもしくはカンマがある場合は、それぞれに大してAND(絞り込み)検索としたい
      # * 検索対象はタイトルだけでなく、説明文(まだない)も対象としたい
      if params[:words].present?
        q = Game.arel_table[:title].matches("%#{params[:words]}%")
        @games = @games.where(q)
      end

      if params[:category].present?
        @games = @games.where(category_id: params[:category])
      end

      if params[:platform].present?
        @games = @games.platform(params[:platform])
      end

      @games.order(created_at: :desc)
      render 'index', formats: 'json', handlers: 'jbuilder'
    end


    private
    def set_platforms
      @platforms = Platform.all
    end

  end

end
