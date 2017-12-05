module Api

  class CategoriesController < ApplicationController

    def index
      categories = Category.select(:id, :name)
      render json: categories
    end

  end

end