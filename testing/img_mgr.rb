require 'sinatra'

get "/" do
  erb :form
end

get "/show" do
  erb :show_image
end

post '/save_image' do

  @filename = params[:file][:filename]
  file = params[:file][:tempfile]

  File.open("./public/#{@filename}", 'wb') do |f|
    #put in path to user specific folder
    #table will store string of filepath to display
    f.write(file.read)
  end

  erb :show_image
end
