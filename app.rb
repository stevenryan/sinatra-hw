require "sinatra"
require "sinatra/activerecord"
require "./models"

set :database, "sqlite3:snacks.sqlite3"

get '/' do
  @blogs = Blog.all
  erb :index
end

post '/makeEntry' do
  title = params[:title]
  content = params[:content]
  date = params[:date]
  Blog.create(title: title, content: content, date: date)
  redirect "/"
end

get '/show/:id' do
  @blog = Blog.find(params[:id])
  erb :selectedPost
end

get '/show/:id/edit' do
  @blog = Blog.find(params[:id])
  erb :edit
end

post '/editEntry/:id' do
  @blog = Blog.find(params[:id])
  @blog.update(title: params[:title], date: params[:date], content: params[:content])
  redirect '/'
end

post '/destroy/:id' do
  @blog = Blog.find(params[:id])
  @blog.destroy
  redirect '/'
end
