module EventStore
  class FileBasedEventStore

    attr_accessor :store_path

    def initialize &block
      Dir.chdir("#{File.dirname(__FILE__)}/../public")
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
          @month = group[1]
          @year = group[0]
          @key = "#{Date::MONTHNAMES[@month.to_i].capitalize} #{@year}"
        end

        data.store @key, [:title => YAML::load(File.read(filename))[:body]['h1_1'], :day => @day, :link => "/event/#{@year}/#{@month}/#{@day}"]
      end
      binding.pry
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

    def get_event_on_year_month_and_day year, month, day
      Dir.chdir(@store_path)
      YAML::load(File.read("#{year}#{month}#{day}.yaml"))
    end

    def put_event(body, year, month, day)
      File.open("#{store_path}/#{year}#{month}#{day}.yaml", 'w') do |file|
        file.write(body)
      end
    end
  end
  class S3EventStore
    ACCESS_KEY = ENV['FP_AWS_ACCESS_KEY']
    SECRET_ACCESS_KEY = ENV['FP_AWS_SECRET_ACCESS_KEY']
    BUCKET = 'gt40.freakypenguin.com'
    puts ACCESS_KEY
    puts SECRET_ACCESS_KEY
    
    def initialize
      @s3 = RightAws::S3.new(ACCESS_KEY, SECRET_ACCESS_KEY)
      @gt40bucket = @s3.bucket(BUCKET)
    end

    def get_timeline
      filenames = @gt40bucket.keys.select{|article| article.to_s =~ /.yaml/}
      data = Hash.new
      filenames.each do |s3Obj|
        puts s3Obj.to_s
        s3Obj.to_s.scan(/articles\/(....)(..)(..)/) do |group|
          @day = group[2]
          @month = group[1]
          @year = group[0]
          @key = "#{Date::MONTHNAMES[@month.to_i].capitalize} #{@year}"
        end
        data[@key] ||= []
        data[@key] << {:title => YAML::load(@gt40bucket.get(s3Obj))[:body]['h1_1'], :day => @day, :link => "/event/#{@year}/#{@month}/#{@day}"}
      end
      data
    end

    def get_all_events_for_year year

    end

    def get_all_events_for_year_and_month year, month

    end

    def put_event(body, year, month, day)
      @gt40bucket.put("pages/#{year}#{month}#{day}.yaml", body, 'public-read')
    end
  end
end
