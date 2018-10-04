require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/namespace'
require './config/environments'
require './models/book'
require './utils/parser'
require './routes/index'
require './middlewares/tarmac_middleware'
require './utils/status_codes'

use TarmacMiddleware

not_found do
  halt(StatusCodes::STATUS_NOT_FOUND, { message: "#{request.path} Path Not Found" }.to_json )
end


