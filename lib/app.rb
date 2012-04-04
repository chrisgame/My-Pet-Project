class MyPetProject < Sinatra::Base

  get '/' do
      haml :index
  end

  get '/timeline' do
    haml :timeline, {}, :locals => EVENT_STORE.get_timeline
  end

  get '/menu' do
    haml :menu
  end
end
