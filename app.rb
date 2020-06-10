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

p '###############'
p params
  erb :comment
end


post '/comment_create' do
Comment.create(
contribution_id: params[:contribution_id],
body: params[:body]
)
redirect "/prefecture/#{params[:prefecture_id]}"
end