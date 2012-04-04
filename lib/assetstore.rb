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
      Dir.chdir("#{File.dirname(__FILE__)}/../public/")
      Dir.chdir("store")
      File.open(File.join(Dir.pwd, "/", name), "wb") {|file| file.write(tempfile.read) }
    end

    def get_path_for_image_with_filename_of filename
      "../store/#{filename}"
    end
  end

  class S3BasedAssetStore

  end
end