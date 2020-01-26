class Search < ApplicationRecord
  belongs_to :title, optional: true
  belongs_to :author, optional: true

  scope :find_title,  lambda { |name| where(titles: { name: name })  }
  scope :find_author, lambda { |name| where(authors: { name: name }) }

  def self.is_search_unique?(params)
    title  = params[:title]&.downcase
    author = params[:author]&.downcase
    is_search_empty = find_search(title, author).empty?

    create_search(title, author) if is_search_empty
    is_search_empty
  end

  private

  def self.find_search(title, author)
    Search.includes(:title, :author)
          .find_title(title)
          .find_author(author)
  end

  def self.create_search(title_name, author_name)
    title  = Title.find_or_create_by(name: title_name)
    author = Author.find_or_create_by(name: author_name)

    Search.create(title: title, author: author)
  end
end
