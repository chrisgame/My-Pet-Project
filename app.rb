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
    YAML::load(File.read("#{year}#{month}#{day}.yaml")).collect{|key, value| "The key is #{key}, the value is #{value}\n"}
  end

  put '/event/:year/:month/:day' do |year, month, day|
    event = YAML::Store.new( "#{year}#{month}#{day}.yaml", :Indent => 2 )
    event.transaction do
      event[:h1] = 'The H1 of the page'
      event[:p] = "Test Page body for #{year}#{month}#{day}"
    end
    "Stored event for #{year}#{month}#{day}"
  end
  run! if app_file == $0
end
