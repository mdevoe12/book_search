RSpec.describe 'Search Controller', type: :request do
  context 'successful results' do
    it 'sends a valid response' do
      mock_data = {
        'docs' => [
          {
            'title_suggest' => 'test title',
            'author_name' => 'test author'
          }
        ]
      }

      stub_request(:get, "http://openlibrary.org/search.json?author=test%20author").
        with(
          headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.0.0'
          }).
        to_return(status: 200, body: "", headers: {})

      allow(JSON).to receive(:parse).and_return(mock_data)

      params = { author: 'test author' }

      get '/api/v1/search', params: params

      expect(response.code).to eq('200')
    end
  end

  context 'unsuccessful requests' do
    it 'sends a 400 if no search params are sent' do
      get '/api/v1/search'

      expect(response.code).to eq('400')
    end

    it 'sends a 503 if the Open Library API fails' do
      stub_request(:get, "http://openlibrary.org/search.json?author=gaiman").
        with(
          headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.0.0'
          }).
        to_return(status: 503, body: "failure", headers: {})

      params = { author: 'gaiman' }

      get '/api/v1/search', params: params

      expect(response.code).to eq('503')
    end
  end
end