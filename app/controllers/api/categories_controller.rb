module Api

  class CategoriesController < ApplicationController

    def index
      @categories = Category.all
      render 'index', formats: 'json', handlers: 'jbuilder'
    end

  end

end