require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'open-uri'
require 'sinatra/json'
require './models/contribution.rb'

get '/' do
  @comments = Contribution.all.order('id desc')
  erb :index
end

post '/' do
  erb :show
end

post '/new' do
  Contribution.create({
    title: params[:title],
    body: params[:body],
    course: params[:course]
  })
  redirect '/'
end