require 'rubygems'
require 'haml'
require 'sinatra'
#require 'pstore'

class MyPetProject < Sinatra::Base

  configure do
#    @Test = 'test'
#    @events = Events.new
    set :public, "#{Dir.pwd}/public"
  end

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
#
#  get '/event/:year/:month' do |year, month|
#    if month > 12.to_s
#      "There are only twelve months"
#    else
#      "Year is  #{year} "+
#      "month is  #{month}"
#    end
#  #  haml :event
#  end
#
#  get '/event/:year/:month/:day' do |year, month, day|
#    @Test
#  #  @events.events.each do |event|
#  #    event
#  #  end
#  #
#  ##  haml :event
#  end
#
#  put '/event/:year/:month/:day' do |year, month, day|
#  #  @events.add_event(:test1 => params["Test Page body for #{year}#{month}#{day}"])
#  end

end

#class Events
#  def initialize(filename="events.pstore")
#    @filename = filename
#  end
#
#  def store
#    @store ||= PStore.new(@filename)
#  end
#
#  def add_event(event)
#    store.transaction do
#      store[:events] ||= []
#      store[:events] << event
#    end
#  end
#
#  def events(readonly=true)
#    store.transaction do
#      store[:events]
#    end
#  end
#
#  def clear_events
#    store.transaction do
#      store[:events]=[]
#    end
#  end
#end


