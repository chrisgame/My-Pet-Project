class MyPetProject < Sinatra::Base
  get '/upload' do
    haml :upload
  end

  post '/upload' do
    unless params[:file] && (tmpfile = params[:file][:tempfile]) && (name = params[:file][:filename])
      return 'WRONG!'
    end

    ASSET_STORE.save(tmpfile, name)
    'Correct!'
  end

  get '/images/:filename' do |filename|
    ASSET_STORE.get_path_for_image_with_filename_of filename

    haml :single_image
  end

  get '/gallery' do
    haml :gallery
  end

  get '/gallery/timeline' do
    haml :gallery_timeline
  end
end


