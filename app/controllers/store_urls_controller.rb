class StoreUrlsController < ApplicationController
  before_action :set_store_url, only: [:show, :edit, :update, :destroy]

  # GET /store_urls
  # GET /store_urls.json
  def index
    @store_urls = StoreUrl.all
  end

  # GET /store_urls/1
  # GET /store_urls/1.json
  def show
  end

  # GET /store_urls/new
  def new
    @store_url = StoreUrl.new
  end

  # GET /store_urls/1/edit
  def edit
  end

  # POST /store_urls
  # POST /store_urls.json
  def create
    @store_url = StoreUrl.new(store_url_params)

    respond_to do |format|
      if @store_url.save
        format.html { redirect_to @store_url, notice: 'Store url was successfully created.' }
        format.json { render :show, status: :created, location: @store_url }
      else
        format.html { render :new }
        format.json { render json: @store_url.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /store_urls/1
  # PATCH/PUT /store_urls/1.json
  def update
    respond_to do |format|
      if @store_url.update(store_url_params)
        format.html { redirect_to @store_url, notice: 'Store url was successfully updated.' }
        format.json { render :show, status: :ok, location: @store_url }
      else
        format.html { render :edit }
        format.json { render json: @store_url.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /store_urls/1
  # DELETE /store_urls/1.json
  def destroy
    @store_url.destroy
    respond_to do |format|
      format.html { redirect_to store_urls_url, notice: 'Store url was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store_url
      @store_url = StoreUrl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_url_params
      params.require(:store_url).permit(:game_id, :platform_id, :url, :memo)
    end
end
