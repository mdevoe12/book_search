class Search < ApplicationRecord
  belongs_to :title, optional: true
  belongs_to :author, optional: true

  scope :find_title, lambda { |name| where(titles: { name: name }) }
  scope :find_author, lambda { |name| where(authors: { name: name }) }

  def self.is_search_unique?(params)
    search = Search.includes(:title, :author)
                   .find_title(params[:title])
                   .find_author(params[:author])

    search.empty?
  end
end
