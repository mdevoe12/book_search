class BooksPresenter
  attr_reader :raw_info

  def initialize(response_body, sort_params)
    @raw_info = response_body['docs']
    @sort_by  = sort_params[:sort_by]
    @order_by = sort_params[:order_by]
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
    order = determine_sort_order

    if @sort_by == 'author'
      self.send("sort_by_author_#{order}", data)
    else
      self.send("sort_by_title_#{order}", data)
    end
  end

  private

  def determine_sort_order
    @order_by == 'desc' ? 'desc' : 'asc'
  end

  def sort_by_title_asc(data)
    data.sort! { |x, y| x[:title] <=> y[:title] }
  end

  def sort_by_title_desc(data)
    data.sort! { |x, y| y[:title] <=> x[:title] }
  end

  def sort_by_author_asc(data)
    data.sort! { |x, y| x[:author] <=> y[:author] }
  end

  def sort_by_author_desc(data)
    data.sort! { |x, y| y[:author] <=> x[:author] }
  end

end