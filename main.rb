require 'rubygems'
require 'sinatra'
require 'haml'

@@data = []

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
  "Year is  #{year} "+
  "month is  #{month} "+
  "day is  #{day}"
#  haml :event
end

put '/event/:year/:month/:day' do |year, month, day|
  @@data => "#{year}#{month}#{day}"
  "#{year}#{month}#{day}"
end

