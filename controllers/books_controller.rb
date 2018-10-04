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
  @page = params[:page] || DEFAULT_PAGE
  @limit = params[:limit] || DEFAULT_LIMIT
  @books = Book.paginate(:page => @page, :per_page => @limit)
  {
    page: @page,
    limit: @limit,
    data: @books
  }.to_json
end
  
post '/books' do
  @book = Book.new(Parser.parse(request.body.read))
  puts @book
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