require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require './models/item.rb'

get '/' do
  erb :index
end

post '/' do
  "Hello World"
end

post '/new' do
  "Hello World!"
  redirect '/'
end