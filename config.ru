require 'rubygems'
require 'haml'
require 'sinatra'
require 'yaml'
require 'pstore'
require 'yaml/store'
require "#{File.dirname(__FILE__)}/lib/app"
require "#{File.dirname(__FILE__)}/lib/events"
require "#{File.dirname(__FILE__)}/lib/assets"
require "#{File.dirname(__FILE__)}/lib/eventstore"
require "#{File.dirname(__FILE__)}/lib/assetstore"

$0 = 'My-Pet-Project-App'

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
    EVENT_STORE = EventStore::FileBasedEventStore.new
    ASSET_STORE = AssetStore::FileBasedAssetStore.new
  end

  configure(:debug) do
    self.configure_app 'localhost:3000'
  end

  configure(:local) do
      self.configure_app 'localhost:3000'
#    register Sinatra::Reloader
#    also_reload File.dirname(__FILE__) + "/views"
  end

  configure(:staging) do
    self.configure_app 'http://simple-mountain-4376.herokuapp.com/'
    EVENT_STORE = EventStore::S3EventStore.new
    require 'newrelic_rpm'
  end

  configure(:production) do
    self.configure_app 'http://empty-frost-9387.herokuapp.com/'
    EVENT_STORE = EventStore::S3EventStore.new
    require 'newrelic_rpm'
  end

end

run MyPetProject