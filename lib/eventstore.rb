module EventStore
  class FileBasedStore

    attr_accessor :store_path

    def initialize &block
      Dir.chdir("#{File.dirname(__FILE__)}/../")
      yield if block_given?
      Dir.mkdir("store") unless File.directory?("store")
      Dir.chdir("store")
      @store_path = Dir.pwd
    end

    def get_timeline
      Dir.chdir(@store_path)
      filenames = Dir.glob("*.yaml")
      data = Hash.new
      filenames.each do |filename|
        filename.scan(/(....)(..)(..)/) do |group|
          @day = group[2]
          @key = "#{Date::MONTHNAMES[group[1].to_i].capitalize} #{group[0]}"
        end

        data.store @key, [:title => YAML::load(File.read(filename))[:body]['h1_1'], :day => @day]
      end
      data
    end

    def get_all_events_for_year year
      Dir.chdir(@store_path)
      filenames = Dir.glob("#{year}*")
      data = Hash.new
      filenames.each { |filename| data.store "#{filename.gsub(/.yaml/, '')}", YAML::load(File.read(filename)) }
      data
    end

    def get_all_events_for_year_and_month year, month
      Dir.chdir(@store_path)
      filenames = Dir.glob("#{year}#{month}*")
      data = Hash.new
      filenames.each { |filename| data.store "#{filename.gsub(/.yaml/, '')}", YAML::load(File.read(filename)) }
      data
    end

    def put_event(body, year, month, day)
      File.open("#{store_path}/#{year}#{month}#{day}.yaml", 'w') do |file|
        file.write(body)
      end
    end
  end
  class S3Store
    AWS_ACCESS_KEY = 'AKIAI3HDDHE7NJ2HWRQA'
    AWS_SECRET_ACCESS_KEY = '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'
    AWS_BUCKET = 'gt40.freakypenguin'

    def get_all_events_for_year year

    end

    def get_all_events_for_year_and_month year, month

    end

    def put_event(body, year, month, day)
      s3 = RightAws::S3.new(AWS_ACCESS_KEY, AWS_SECRET_ACCESS_KEY)
      gt40bucket = s3.bucket(AWS_BUCKET)
      gt40bucket.put("carbuildsite/#{year}#{month}#{day}.yaml", body, 'public-read')
    end
  end
end
