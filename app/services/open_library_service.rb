class OpenLibraryService
  BASE_URL = 'http://openlibrary.org/search.json'

  def self.get(params)
    Faraday.get(BASE_URL, params)
  end
end