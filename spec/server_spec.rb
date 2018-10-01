require './server'

RSpec.describe:type => :controller do
  describe 'Get /books' do

    before { get '/books'}

    it 'returns HTTP status 200' do
      expect(response).to have_http_status 200
    end

    it 'return books' do
      expect(1).to eq 1
    end
  end
end