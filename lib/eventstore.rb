module EventStore
  class FileBasedStore
    def initialize
      Dir.chdir("store")
    end

    def get_all_events_for_year year
      filenames = Dir.glob("#{year}*")
      data = Hash.new
      filenames.each{|filename| data.store "#{filename.gsub(/.yaml/, '')}", YAML::load(File.read(filename))}
      data
    end

    def get_all_events_for_year_and_month year, month
      filenames = Dir.glob("#{year}#{month}*")
      data = Hash.new
      filenames.each{|filename| data.store "#{filename.gsub(/.yaml/, '')}", YAML::load(File.read(filename))}
      data
    end
  end
  class S3Store

  end
end
