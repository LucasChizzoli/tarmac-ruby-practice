require './controllers/books_controller'
require "sinatra/base"

namespace '/books' do
  new :books
end