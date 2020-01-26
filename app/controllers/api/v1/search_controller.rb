class Api::V1::SearchController < ApplicationController
  def index
    return invalid_search if search_params.empty?

    response = OpenLibraryService.get(search_params)
    result = JSON.parse(response.body)

    render json: result, status: 200
  end

  private

  def search_params
    params.permit(:title, :author)
  end

  def invalid_search
    error = {
      message: 'Missing search parameters or invalid syntax'
    }

    render json: error, status: 400
  end
end