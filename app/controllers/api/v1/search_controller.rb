class Api::V1::SearchController < ApplicationController
  def index
    response = OpenLibraryService.get(search_params)
    result = JSON.parse(response.body)

    render json: result, status: 200
  end

  private

  def search_params
    params.permit(:title)
  end
end