require 'sinatra'
require 'sinatra/activerecord'
enable :sessions
require 'active_record'

# ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])

set :public_folder, File.dirname(__FILE__) + '/publics'

set :database, "sqlite3:fishbook.sqlite3"

get '/' do
  # @users = User.all
  erb :login
end

get '/profile' do
  erb :profile
end

get '/invalid' do
  erb :invalid
end

get '/signedup' do
  erb :signedup
end


post '/signup' do
  p params
  user = User.new(
    email: params["email"],
    name: params["name"],
    last_name: params["last_name"],
    password: params["password"],
    bday: params["bday"],
    image_url: params["image_url"]
  )
  user.save
  redirect "/signedup"
end

post '/login' do
email = params[:email]
given_password = params[:password]
user = User.find_by(email: email)
if user.password == given_password
session[:user] = user
redirect '/profile'
else
  redirect '/invalid'
end
end

get "/log_out" do
  session[:user] = nil
  redirect "/"
end

get "/settings" do
    erb :settings
end
get 'post' do
  @posts = Post.all
  erb :post
end

post '/post' do
  user = User.find(session[:user].id)
  post = Post.new(
    owner: user.email,
    title: params["title"],
    content: params["content"],
  )
  post.save
  redirect '/profile'
end

put "/settings" do
  user = session[:user]
  user.update(
    name: params[:name],
    last_name: params[:last_name],
    email: params[:email],
    password: params[:password],
    image_url: params[:image_url])
    redirect "/profile"
end


post "/settings" do
    named = session[:user].email
    user = User.find(session[:user].id)
  if user.email == params[:email] && user.password == params[:password]
    diePost = Post.where(owner: named)
    diePost.each do |po|
      po.destroy
    end
    User.destroy(session[:user].id)
    session[:user] = nil
    redirect "/"
  else
    redirect "/settings"
  end
end

require "./models"
