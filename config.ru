require './lib/app'
require 'pstore'
require 'yaml/store'

class MyPetProject < Sinatra::Base

  configure do
    set :public, "#{Dir.pwd}/public"
  end

end

MyPetProject.run!