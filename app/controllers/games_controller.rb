class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @categories = Category.all
    @game = current_user.games.build
  end

  # GET /games/1/edit
  def edit
    @categories = Category.all
  end

  # POST /games
  # POST /games.json
  def create
    @game = current_user.games.build(game_params)

    if params[:game][:icon]
      @game.icon = params[:game][:icon] # Assign a file like this
    end

    respond_to do |format|
      if @game.save
        pp @game.icon.url # => '/url/to/file.png'
        pp @game.icon.current_path # => 'path/to/file.png'
        pp @game.icon.thumb.url
        pp @game.icon.thumb.current_path
        pp @game.icon_identifier # => 'file.png'

        format.html {redirect_to @game, notice: 'Game was successfully created.'}
        format.json {render :show, status: :created, location: @game}
      else
        format.html {render :new}
        format.json {render json: @game.errors, status: :unprocessable_entity}
      end
    end


  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html {redirect_to @game, notice: 'Game was successfully updated.'}
        format.json {render :show, status: :ok, location: @game}
      else
        format.html {render :edit}
        format.json {render json: @game.errors, status: :unprocessable_entity}
      end
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

  # Never trust parameters from the scary internet, only allow the white list through.
  def game_params
    params.require(:game).permit(:title, :permission, :specific_conditions, :android_url, :ios_url, :icon, :category_id)
  end

  # Confirms the correct user.
  def correct_user
    if @game.user != current_user
      redirect_to(root_url)
    end
  end
end
