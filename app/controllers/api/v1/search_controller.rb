class Api::V1::SearchController < ApplicationController
  def index
    return invalid_search if search_params.empty?

    response = OpenLibraryService.get(search_params)
    return api_error if response.status != 200

    render json: results(response), status: 200
  end

  private

  def search_params
    params.permit(:title, :author)
  end

  def sort_params
    params.permit(:sort_by, :order_by)
  end

  def invalid_search
    error = {
      message: 'Missing search parameters or invalid syntax'
    }

    render json: error, status: 400
  end

  def api_error
    error = {
      message: 'Open Library API has failed to respond properly. Please try again.'
    }

    render json: error, status: 503
  end

  def results(response)
    is_search_unique = Search.is_search_unique?(search_params)

    parsed_body = JSON.parse(response.body)
    books_data = BooksPresenter.format_data(parsed_body, sort_params)

    {
      is_search_unique: is_search_unique,
      books: books_data
    }
  end
end