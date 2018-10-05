require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/namespace'
require './config/environments'
require './models/book'
require './utils/status_codes'
require './utils/parser'
require './utils/book_validation'
require 'will_paginate'
require 'will_paginate/active_record'
require 'will_paginate/view_helpers/sinatra'

DEFAULT_PAGE = 1
DEFAULT_LIMIT = 5

get '/books' do 
  build_book_model(params)
  @page = params[:page] || DEFAULT_PAGE
  @limit = params[:limit] || DEFAULT_LIMIT
  @query = get_book_query(build_book_model(params))
  @books = Book.where(@query).paginate(:page => @page, :per_page => @limit)
  {
    page: @page,
    limit: @limit,
    data: @books
  }.to_json
end
  
post '/books' do
  @book = Book.new(Parser.parse(request.body.read))
  halt(StatusCodes::STATUS_BAD_REQUEST, { message: 'Invalid Data' }.to_json ) unless BookValidation.validate(@book)
  if @book.save
    status StatusCodes::STATUS_OK
    return @book.id.to_json
  else
    status StatusCodes::STATUS_BAD_REQUEST
  end
end
  
get '/books/:id' do |id|
  @book = Book.where(id: id).first
  halt(StatusCodes::STATUS_NOT_FOUND, { message: 'Book Not Found' }.to_json) unless @book
  @book.to_json
end
  
delete '/books/:id' do |id|
  @book = Book.where(id: id).first
  @book.destroy if @book
  status StatusCodes::STATUS_OK
end
  
put '/books/:id' do |id|
  @book = Book.where(id: id).first
  halt(StatusCodes::STATUS_NOT_FOUND, { message: 'Book Not Found' }.to_json) unless @book
  if @book.update_attributes(Parser.parse(request.body.read))
    status StatusCodes::STATUS_OK
    return @book.id.to_json
  else
    status StatusCodes::STATUS_UNPROCESSABLE_ENTITY
    @book
  end
end

def build_book_model(params)
  {
    "isbn" => params['isbn'],
    "title" => params['title'],
    "publisher" => params['publisher'], 
    "releasedate" => params['releasedate'],
    "website" => params['website']
  }
end

def get_book_query(book)
  @query = {}
  if book['title'] && book['title'].strip != '' then
    @query['title'] = book['title']
  end
  if book['publisher'] && book['publisher'].strip != '' then
    @query['publisher'] = book['publisher']
  end
  if book['website'] && book['website'].strip != '' then
    @query['website'] = book['website']
  end
  if book['releasedate'] && book['releasedate'].strip != '' then
    @query['releasedate'] = book['releasedate']
  end
  if book['isbn'] && book['isbn'].strip != '' then
    @query['isbn'] = book['isbn']
  end
  @query
end