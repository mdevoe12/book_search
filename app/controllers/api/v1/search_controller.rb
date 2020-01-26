class Api::V1::SearchController < ApplicationController
  def index
    result = {
      data: 'sample data'
    }

    render json: result, status: 200
  end
end