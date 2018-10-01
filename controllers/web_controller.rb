require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/namespace'

get '/' do
  erb :books
end

get '/new' do
  erb :new_book
end