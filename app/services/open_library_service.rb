class OpenLibraryService
  def self.get
    Faraday.get('http://openlibrary.org/search.json', { title: 'american+gods' })
  end
end