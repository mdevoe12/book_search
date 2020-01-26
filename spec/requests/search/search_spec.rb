RSpec.describe 'Search Controller', type: :request do
  context 'successful results' do
    it 'sends a valid response' do
      get '/api/v1/search'

      expect(response.code).to eq('200')
    end
  end
end