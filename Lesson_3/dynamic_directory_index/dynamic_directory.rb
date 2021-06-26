require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  @directory = Dir.glob("public/*").map { |file| File.basename(file) }.sort
  @directory.reverse! if params[:sort] == "desc"

  erb :list
end