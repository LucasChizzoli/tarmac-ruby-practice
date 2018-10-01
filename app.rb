require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/namespace'
require 'rack/reducer'
require './config/environments'
require './models/book'
require './utils/parser'
require './routes/index'
require './middlewares/tarmac_middleware'

use TarmacMiddleware


