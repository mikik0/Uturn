require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'open-uri'
require 'sinatra/json'
require './models/contribution.rb'


get '/' do
  @comments = Comment.all
  @contributions = Contribution.all
  @prefectures = Prefecture.all
  erb :index
end

get '/prefectures/:id/contributions' do
  @prefectures   = Prefecture.all
  @prefecture    = Prefecture.find(params[:id])
  @contributions = @prefecture.contributions
  @comments = Comment.where(prefecture_id: params[:id])
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

get '/prefectiures/:id/contributions/:c_id/comments' do
  @contribution = Contribution.find(params[:c_id])
  @comments = @contribution.comments
p '##########################'
p params[:id]
  erb :comment
end

post '/comment_create' do
  Comment.create(
    contribution_id: params[:c_id],
    body: params[:body]
  )
redirect "/prefectiures/:id/contributions/:c_id/comments"
end