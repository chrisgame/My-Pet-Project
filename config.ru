require './lib/app'
require './lib/eventstore'
require 'pstore'
require 'yaml/store'
#require "sinatra/reloader"

$0 = 'My-Pet-Project'

class MyPetProject < Sinatra::Base

  class << self
    attr_reader :base_url

    def configure_app base_url
      @base_url = base_url
    end
  end

  configure do
    set :public_folder, "#{Dir.pwd}/public"
    set :views, File.dirname(__FILE__) + "/views"
    STORE = EventStore::FileBasedStore.new
  end

  configure(:local) do
    self.configure_app 'localhost:3000'
#    register Sinatra::Reloader
#    also_reload File.dirname(__FILE__) + "/views"
  end

  configure(:staging) do
    self.configure_app 'http://simple-mountain-4376.herokuapp.com/'
    STORE = EventStore::S3Store.new
  end

  configure(:production) do
    self.configure_app 'http://empty-frost-9387.herokuapp.com/'
    STORE = EventStore::S3Store.new
  end

end

run MyPetProject