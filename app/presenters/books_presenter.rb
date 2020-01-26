class BooksPresenter
  attr_reader :raw_info

  def initialize(params)
    @raw_info = params['docs']
  end

  def format_raw_info
    raw_info.map do |info|
      {
        title: info['title_suggest'],
        author: info['author_name']
      }  
    end.compact
  end
end