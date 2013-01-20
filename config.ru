require 'rubygems'
require 'haml'
require 'sinatra'
require "sinatra/reloader"
require 'yaml'
require 'pstore'
require 'yaml/store'
require 'exifr'
require 'open3'
require 'time'
require 'pp'
require 'right_aws'
require 'pry'
require "#{File.dirname(__FILE__)}/lib/app"
require "#{File.dirname(__FILE__)}/lib/events"
require "#{File.dirname(__FILE__)}/lib/assets"
require "#{File.dirname(__FILE__)}/lib/eventstore"
require "#{File.dirname(__FILE__)}/lib/assetstore"

class MyPetProject < Sinatra::Base
  configure do
    set :public_folder, "#{Dir.pwd}/public"
    set :views, File.dirname(__FILE__) + "/views"
  end

  configure(:development) do
    EVENT_STORE = EventStore::FileBasedEventStore.new
    ASSET_STORE = AssetStore::FileBasedAssetStore.new
    register Sinatra::Reloader
    also_reload File.dirname(__FILE__) + "/views"
    also_reload File.dirname(__FILE__) + "/lib"
  end

  configure(:production) do
    EVENT_STORE = EventStore::S3EventStore.new
    require 'newrelic_rpm'
  end

end

run MyPetProject
