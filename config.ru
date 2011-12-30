require './lib/app'
require './lib/eventstore'
require 'pstore'
require 'yaml/store'
#require "sinatra/reloader"

$0 = 'My-Pet-Project'

class MyPetProject < Sinatra::Base

  configure do
    set :public_folder, "#{Dir.pwd}/public"
    set :views, File.dirname(__FILE__) + "/views"
    STORE = EventStore::FileBasedStore.new
  end

  configure(:local) do
    self.configure 'localhost:4567'
#    register Sinatra::Reloader
#    also_reload File.dirname(__FILE__) + "/views"
  end

  configure(:production) do
    self.configure 'fred'
    STORE = EventStore::S3Store.new
  end

end

MyPetProject.run!