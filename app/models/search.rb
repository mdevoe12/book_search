class Search < ApplicationRecord
  belongs_to :title, optional: true
  belongs_to :author, optional: true

  def self.is_search_unique?(params)
    # Search.where(title.name: params[:title], author.name: params[:author])
    Search.joins(:title).where(titles: { name: params[:title] }).empty?
  end
end
