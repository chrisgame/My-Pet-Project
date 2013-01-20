require 'rubygems'
require 'nokogiri'
require 'pp'
require 'exifr'
require 'time'

class Article < Nokogiri::XML::SAX::Document

  def initialize
    super()
    @h1_counter = 1
    @h2_counter = 1
    @p_counter = 1
    @img_counter = 0
    @first_image_path = ''
    @last_element_output_text = ''
    @last_element_type = ''
    @new_file_content = []
  end

  def start_element name, attrs
    attr_hash = Hash[*attrs.flatten]
    if ['body', 'title', 'h1', 'h2', 'p', 'img'].include? name
      case name
        when 'title'
          @last_element_output_text = ":pageTitle:"
        when 'body'
          @new_file_content << ":body:\n"
        when 'h1'
          @last_element_type = 'h1'
          @last_element_output_text = "  h1_#{@h1_counter}:"
        when 'h2'
          @last_element_type = 'h2'
          @last_element_output_text = "  h2_#{@h2_counter}:"
        when 'p'
          @last_element_type = 'p' 
          @last_element_output_text = "  p_#{@p_counter}:"
        when 'img'
          @first_image_path = attr_hash['src'].downcase
          @last_element_type = 'img'
          @img_counter += 1
          @new_file_content << "  image_#{@img_counter}:\n"
          @new_file_content << "    :src: \"#{attr_hash['src'].downcase}\"\n"
          @new_file_content << "    :alt: \"#{attr_hash['alt']}\"\n" 
          @new_file_content << "    :id: \"#{attr_hash['id']}\"\n" 
          @new_file_content << "    :width: \"#{attr_hash['width']}\"\n"
      end
    end 
  end

  def characters string
    if string.strip != ""
      case @last_element_type
        when 'h1'
          @h1_counter += 1
        when 'h2'
          @h2_counter += 1
        when 'p'
          @p_counter += 1
      end
      @new_file_content << "#{@last_element_output_text} #{string}\n"
    end
  end

  def end_document
    begin
      image_file = File.join(File.expand_path(File.dirname(__FILE__)), '/', @first_image_path).gsub('/photos', '/photos sandbox')
      file_date_time = EXIFR::JPEG.new(image_file).exif[:date_time_original]
      if file_date_time
        time = Time.parse(file_date_time.to_s)
      else
        puts 'force time'
        time = Time.parse('Wed Oct 28 16:54:04 +100 2004')
      end
      filename = time.strftime('%Y%m%d')
      puts filename
      puts "#{filename} exists" if FileTest.exists? filename
      output_file = File.new filename+'.yaml', 'w+'
      output_file.write @new_file_content
      output_file.close
    rescue
      puts "error processing #{image_file}"
    end
  end
  
end		

@file_count = 0

Dir.glob(Dir.pwd+'/*.html').sort.each do |f|
  @file_count += 1
  puts @file_count
  filename = File.basename(f, File.extname(f))
  puts filename
  page = Nokogiri::HTML(open(f))	
  xml_page = page.to_xhtml
  sax_parser = Nokogiri::XML::SAX::Parser.new(Article.new)
  sax_parser.parse(xml_page)
end
