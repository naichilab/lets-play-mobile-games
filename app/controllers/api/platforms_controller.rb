module Api

  class PlatformsController < ApplicationController

    def index
      @platforms = Platform.all
      render 'index', formats: 'json', handlers: 'jbuilder'
    end

  end

end