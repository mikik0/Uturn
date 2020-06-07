require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'open-uri'
require 'sinatra/json'
require './models/contribution.rb'


get '/' do
  @comments = Contribution.all.order('id desc')
  @prefectures = Prefecture.all
  erb :index
end

post '/' do
  Contribution.create({
    title: params[:title],
    body: params[:body],
    course: params[:course]
  })
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