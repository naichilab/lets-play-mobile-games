class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:new, :edit, :create, :update]
  before_action :set_platforms, only: [:new, :edit, :create, :update]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = current_user.games.build
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = current_user.games.build(game_params)

    if @game.save

      # todo store_url登録失敗時の処理
      if store_urls_params[:store_url].present?
        @game.store_urls.create(store_urls_params[:store_url])
      end

      redirect_to @game, notice: '登録しました。'
    else
      flash.now[:alert] = "エラーがあるため登録できませんでした。"
      render :new
    end

  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update

    if @game.update(game_params)

      #めんどうなので全消し
      @game.store_urls.each do |url|
        url.destroy
      end

      if store_urls_params[:store_url].present?
        @game.store_urls.create(store_urls_params[:store_url])
      end

      redirect_to @game, notice: '更新しました。'
    else
      flash.now[:alert] = "エラーがあるため更新できませんでした。"
      render :edit
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html {redirect_to games_url, notice: 'Game was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
  end

  def set_categories
    @categories = Category.all
  end

  def set_platforms
    @platforms = Platform.all
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def game_params
    params.require(:game).permit(:title, :permission, :specific_conditions, :icon, :category_id, :guideline)
  end

  def store_urls_params
    params.require(:game).permit(store_url: [:platform_id, :url, :memo])
  end

  # Confirms the correct user.
  def correct_user
    if @game.user != current_user
      render template: "errors/forbidden", layout: false, status: :forbidden
    end
  end

end
