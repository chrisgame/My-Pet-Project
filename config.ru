require 'app'
require 'pstore'

class MyPetProject::Events
  def initialize(filename="events1.pstore")
    @filename = filename
  end

  def store
    @store ||= PStore.new(@filename)
  end

  def add_event(event)
    store.transaction do
      store[:events] ||= []
      store[:events] << event
    end
  end

  def events(readonly=true)
    store.transaction do
      store[:events]
    end
  end

  def clear_events
    store.transaction do
      store[:events]=[]
    end
  end
end

class MyPetProject < Sinatra::Base

  configure do
    @@events = MyPetProject::Events.new
    set :public, "#{Dir.pwd}/public"
  end

end

run MyPetProject