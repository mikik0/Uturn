require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'open-uri'
require 'sinatra/json'
require './models/contribution.rb'


get '/' do
  @comments = Contribution.all.order('id desc')
  @contributions = Contribution.all
  @prefectures = Prefecture.all
  p '###########'
  p @prefectures

  erb :index
end

get '/prefecture/:id' do
  @prefectures   = Prefecture.all
  @prefecture    = Prefecture.find(params[:id])
  @prefecture_name = @prefecture.name
  @contributions = @prefecture.contributions
  erb :show
end

post '/new' do
  Contribution.create({
    prefecture_id: params[:prefecture],
    course: params[:course],
    body: params[:body]
  })
  redirect '/'
end