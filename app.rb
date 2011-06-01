require 'rubygems'
require 'bundler/setup'
require 'haml'
require 'sinatra'

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
    @@events.events.each do |event|
      event
    end
  #  haml :event
  end

  put '/event/:year/:month/:day' do |year, month, day|
    @@events.add_event 'cheese'
#    @events.add_event(:test1 => params["Test Page body for #{year}#{month}#{day}"])
    "Received #{year}#{month}#{day}"
  end
  run! if app_file == $0
end


