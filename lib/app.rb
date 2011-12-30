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
    haml :events, {}, :locals => STORE.get_all_events_for_year(year)
  end

  get '/event/:year/:month' do |year, month|
    if month > 12.to_s
      "There are only twelve months"
    else
     haml :events, {}, :locals => STORE.get_all_events_for_year_and_month(year, month)
    end
  end

  get '/event/:year/:month/:day' do |year, month, day|
      haml:event, {}, :locals => YAML::load(File.read("../store/#{year}#{month}#{day}.yaml"))
  end

  put '/event/:year/:month/:day' do |year, month, day|
    STORE.put_event(request.body.read.to_s, year, month, day)

    "Stored event for #{year}#{month}#{day}"
  end
  run! if app_file == $0
end
