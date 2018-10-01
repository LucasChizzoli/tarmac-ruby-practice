require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/namespace'
require './config/environments'
require './models/book'
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
  Book.paginate(:page => @page, :per_page => @limit).to_json 
end
  
post '/books' do
  @book = Book.new(Parser.parse(request.body.read))
  halt(400, { message: 'Invalid Data' }.to_json ) unless BookValidation.validate(@book)
  if @book.save
    @book
    status 201
  else
    status 400
  end
end
  
get '/books/:id' do |id|
  @book = Book.where(id: id).first
  halt(404, { message: 'Book Not Found' }.to_json) unless @book
  @book.to_json
end
  
delete '/books/:id' do |id|
  @book = Book.where(id: id).first
  @book.destroy if @book
  status 204
end
  
put '/books/:id' do |id|
  @book = Book.where(id: id).first
  halt(404, { message: 'Book Not Found' }.to_json) unless @book
  if @book.update_attributes(Parser.parse(request.body.read))
    @book
  else
    status 422
    @book
  end
end