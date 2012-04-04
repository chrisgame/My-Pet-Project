class MyPetProject < Sinatra::Base
  get '/event/:year' do |year|
    haml :events, {}, :locals => EVENT_STORE.get_all_events_for_year(year)
  end

  get '/event/:year/:month' do |year, month|
    if month > 12.to_s
      "Events may be requested by year, year and month or year month day"
    else
     haml :events, {}, :locals => EVENT_STORE.get_all_events_for_year_and_month(year, month)
    end
  end

  get '/event/:year/:month/:day' do |year, month, day|
      haml:event, {}, :locals => YAML::load(File.read("../store/#{year}#{month}#{day}.yaml"))
  end

  put '/event/:year/:month/:day' do |year, month, day|
    EVENT_STORE.put_event(request.body.read.to_s, year, month, day)

    "Stored event for #{year}#{month}#{day}"
  end
end
