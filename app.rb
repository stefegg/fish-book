require 'sinatra'
require 'sinatra/activerecord'
enable :sessions
require 'active_record'
ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])

set :public_folder, File.dirname(__FILE__) + '/publics'

# set :database, "sqlite3:fishbook.sqlite3"

get '/' do
  @users = User.all
  erb :login
end

get '/profile' do
  erb :profile
end

get '/invalid' do
  erb :invalid
end

post '/signup' do
  p params
  user = User.new(
    email: params["email"],
    name: params["name"],
    last_name: params["last_name"],
    password: params["password"],
    bday: params["bday"]
  )
  user.save
  redirect "/"
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
  if session[:user_id] != nil
    @user = User.find(session[:user_id])
  end
  session[:user_id] = nil
  redirect "/"
end


require "./models"
