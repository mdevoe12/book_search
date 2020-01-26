class BooksPresenter
  attr_reader :raw_info,
              :sort_by

  def initialize(response_body, sort_params)
    @raw_info = response_body['docs']
    @sort_by  = sort_params[:sort_by]
  end

  def self.format_data(response_body, params)
    books = new(response_body, params)
    formatted_data = books.format_raw_info
    books.sort(formatted_data)
  end

  def format_raw_info
    raw_info.map do |info|
      {
        title: info['title_suggest'],
        author: info['author_name']
      }  
    end.compact
  end

  def sort(data)
    @sort_by == 'author' ? sort_by_author(data) : sort_by_title(data)
  end

  def sort_by_title(data)
    data.sort! { |x, y| x[:title] <=> y[:title] }
  end
end