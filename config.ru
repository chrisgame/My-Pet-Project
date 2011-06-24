require './lib/app'
require './lib/eventstore'
require 'pstore'
require 'yaml/store'

class MyPetProject < Sinatra::Base

  configure do
    set :public, "#{Dir.pwd}/public"
    set :views, File.dirname(__FILE__) + "/views"
    STORE = EventStore::FileBasedStore.new
  end

end

MyPetProject.run!