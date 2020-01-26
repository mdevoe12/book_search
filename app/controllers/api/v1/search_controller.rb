class Api::V1::SearchController < ApplicationController
  def index
    response = Faraday.get('http://openlibrary.org/search.json', { title: 'american+gods' })
    result = JSON.parse(response.body)
    # result = {
    #   data: 'sample data'
    # }

    render json: result, status: 200
  end
end