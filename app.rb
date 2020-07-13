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
    title: params[:title],
    body: params[:body],
    good: 0
  })
  redirect '/'
end

get '/prefectiures/:id/contributions/:c_id/comments' do
  @prefectures   = Prefecture.all
  @prefecture    = Prefecture.find(params[:id])
  @contributions = @prefecture.contributions

  @contribution = Contribution.find(params[:c_id])
  @comments = @contribution.comments.order(created_at: :desc)
p '##########################'
p params[:id]
p params[:c_id]
p :c_id
  erb :comment
end

post '/comment_create' do
  @contribution = Contribution.find(params[:c_id])
  Comment.create(
    contribution_id: params[:c_id],
    body: params[:body]
  )
  redirect "/prefectiures/#{@contribution.prefecture_id}/contributions/#{params[:c_id]}/comments"
end

post '/good/:id' do
  contribution = Contribution.find(params[:id])
  good = contribution.good
  contribution.update({
    good: good+1
  })
  redirect "/prefectiures/#{contribution.prefecture_id}/contributions/#{params[:id]}/comments"
end