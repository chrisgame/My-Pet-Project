require 'app'
require 'pstore'
require 'yaml/store'

class MyPetProject < Sinatra::Base

  configure do
    @@events = YAML::Store.new( "pstore.yaml", :Indent => 2 )
    set :public, "#{Dir.pwd}/public"
  end

end

MyPetProject.run!