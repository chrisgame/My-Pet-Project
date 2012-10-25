class MyPetProject < Sinatra::Base

  get '/' do
    @page_title = 'Tornado TS40 GT40 Kit Car Build'

    haml :index
  end

  get '/timeline' do
    @page_title = 'Tornado TS40 GT40 Kit Car Build'
    haml :standalone_timeline
  end

  get '/menu' do
    haml :menu
  end

  def days_in_month month_number
    (Date.new(Time.now.year,12,31).to_date<<(12-month_number)).day
  end
end
