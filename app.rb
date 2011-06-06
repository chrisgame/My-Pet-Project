require 'rubygems'
require 'bundler/setup'
require 'haml'
require 'sinatra'
require 'yaml'

class MyPetProject < Sinatra::Base

  get '/' do
      haml :index
  end

  get '/timeline' do
    haml :timeline
  end

  get '/menu' do
    haml :menu
  end

  get '/event/:year' do |year|
    "Year is  #{year}"
  #  haml :event
  end

  get '/event/:year/:month' do |year, month|
    if month > 12.to_s
      "There are only twelve months"
    else
      "Year is  #{year} "+
      "month is  #{month}"
    end
  #  haml :event
  end

  get '/event/:year/:month/:day' do |year, month, day|
    haml:event, :locals => YAML::load(File.read("#{year}#{month}#{day}.yaml"))
  end

  put '/event/:year/:month/:day' do |year, month, day|
    File.open("#{year}#{month}#{day}.yaml", 'w') do |file|
      file.write(request.body.read.to_s)
    end

    "Stored event for #{year}#{month}#{day}"
  end
  run! if app_file == $0
end
