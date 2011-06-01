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
    @@events.transaction do
      @@events["#{year}#{month}#{day}"]['body']
    end
  #  haml :event
  end

  put '/event/:year/:month/:day' do |year, month, day|
    key = "#{year}#{month}#{day}"
    body = "Test Page body for #{year}#{month}#{day}"
    @@events.transaction do
      @@events[key] = {'body' => body}
    end
    "Received #{year}#{month}#{day}"
  end
  run! if app_file == $0
end
