require 'spec_helper'
require 'rack/test'
require './app'
require './utils/status_codes'
require 'json'
require './spec/spec_db'

RSpec.describe 'Book Controller' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  BOOKS_URL = '/books'
  
  let(:book_mock) {
    {
      "isbn" => "1230091823471",
      "title" => "Test book",
      "publisher" => "Test publisher", 
      "releasedate" => "01/01/2018",
      "website" => "https://goodreads.com/"
    }.to_json
  }
  
  describe '/books' do

    it 'returns HTTP status 200' do
      header 'TARMAC_HEADER', 'TARMAC_HEADER'
      get BOOKS_URL
      expect(last_response.status).to eq StatusCodes::STATUS_OK
    end

    it 'returns HTTP status 401 when tarmac header is not present' do
      get BOOKS_URL
      expect(last_response.status).to eq StatusCodes::STATUS_UNAUTHORIZED
    end

    it 'create and retrive book' do
      header 'TARMAC_HEADER', 'TARMAC_HEADER'
      post BOOKS_URL, params = book_mock
      expect(last_response.status).to eq StatusCodes::STATUS_OK
      expect(Integer(last_response.body)).to be_kind_of Numeric
      get BOOKS_URL + '/' + last_response.body
      expect(last_response.status).to eq StatusCodes::STATUS_OK
      expect(last_response.body['isbn']).to eq book_mock['isbn']
    end

    it 'should fail when isbn is not present' do
      header 'TARMAC_HEADER', 'TARMAC_HEADER'
      parsed_book = JSON.parse(book_mock)
      parsed_book['isbn'] = ""
      post BOOKS_URL, params = parsed_book.to_json
      expect(last_response.status).to eq StatusCodes::STATUS_BAD_REQUEST
      expect(JSON.parse(last_response.body)['message']).to eq 'Invalid Data'
    end

    it 'should fail when title is not present' do
      header 'TARMAC_HEADER', 'TARMAC_HEADER'
      parsed_book = JSON.parse(book_mock)
      parsed_book['title'] = ""
      post BOOKS_URL, params = parsed_book.to_json
      expect(last_response.status).to eq StatusCodes::STATUS_BAD_REQUEST
      expect(JSON.parse(last_response.body)['message']).to eq 'Invalid Data'
    end

    it 'should fail when publisher is not present' do
      header 'TARMAC_HEADER', 'TARMAC_HEADER'
      parsed_book = JSON.parse(book_mock)
      parsed_book['publisher'] = ""
      post BOOKS_URL, params = parsed_book.to_json
      expect(last_response.status).to eq StatusCodes::STATUS_BAD_REQUEST
      expect(JSON.parse(last_response.body)['message']).to eq 'Invalid Data'
    end

    it 'should fail when release date is not present' do
      header 'TARMAC_HEADER', 'TARMAC_HEADER'
      parsed_book = JSON.parse(book_mock)
      parsed_book['releasedate'] = ""
      post BOOKS_URL, params = parsed_book.to_json
      expect(last_response.status).to eq StatusCodes::STATUS_BAD_REQUEST
      expect(JSON.parse(last_response.body)['message']).to eq 'Invalid Data'
    end

    it 'should fail when website is not present' do
      header 'TARMAC_HEADER', 'TARMAC_HEADER'
      parsed_book = JSON.parse(book_mock)
      parsed_book['website'] = ""
      post BOOKS_URL, params = parsed_book.to_json
      expect(last_response.status).to eq StatusCodes::STATUS_BAD_REQUEST
      expect(JSON.parse(last_response.body)['message']).to eq 'Invalid Data'
    end
  end
end