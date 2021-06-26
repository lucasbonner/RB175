require 'sinatra'
require 'sinatra/reloader'
require "tilt/erubis"
require 'yaml'

helpers do
  def count_value(hsh, value)
    count = 0
    hsh.each {|key, v| count += v[value].count}
    count
  end

  def get_names(hsh, name)
    result = []
    hsh.each {|key, value| result << key unless key == name.to_sym}
    result
  end
end

not_found do
  redirect "/"
end

get "/" do
  @users = YAML.load_file("users.yaml")

  erb :home
end

get "/:name" do
  @name = params[:name]
  @users = YAML.load_file("users.yaml")
  @user = @users[@name.to_sym]


  erb :user
end