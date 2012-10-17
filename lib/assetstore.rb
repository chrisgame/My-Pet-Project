module AssetStore
  class FileBasedAssetStore

    attr_accessor :store_path

    def initialize &block
      Dir.chdir("#{File.dirname(__FILE__)}/../public")
      yield if block_given?
      Dir.mkdir("store") unless File.directory?("store")
      Dir.chdir("store")
      @store_path = Dir.pwd
    end

    def save(tempfile, name)
      Dir.chdir(@store_path)
      File.open(File.join(Dir.pwd, "/", name), "wb") {|file| file.write(tempfile.read) }
    end

    def get_path_for_image_with_filename_of filename
      Dir.chdir(@store_path)
      "../store/#{filename}"
    end

    def get_all_assets
      Dir.chdir(@store_path)
      assets = []
      Dir.foreach(@store_path){|filename| assets << "store/#{filename}" unless unsupported_image filename}
      assets
    end

    def get_all_assets_grouped_by_year_then_month
      Dir.chdir(@store_path)
      assets = Hash.new{|hash, key| hash[key] = Array.new}
      Dir.foreach(@store_path) do |filename|
        case filename
          when /.jpg$|.jpeg$/
            filedate = EXIFR::JPEG.new(File.join(Dir.pwd, "/", filename)).date_time
            if filedate.nil?
              key = :UNKNOWN
            else
              year,month,day,nr1,nr2 = filedate.to_s.split(/ |-/)
              key = "#{year}#{month}#{day}"
            end
            assets[key] << "store/#{filename}" unless unsupported filename
        end
      end
      assets
    end

    def unsupported filename
      ['.', '..'].include? filename
    end

    def unsupported_image filename
      ['.', '..', 'yml', 'yaml'].include? filename
    end
  end

  class S3BasedAssetStore

  end
end