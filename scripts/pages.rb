require 'rubygems'
require 'nokogiri'
require 'pp'

class Article < Nokogiri::XML::SAX::Document

  def initialize
    @h1_counter = 1
    @h2_counter = 1
    @p_counter = 1
    @img_counter = 0
    @last_element_output_text = ''
    @last_element_type = ''
  end

  def start_element name, attrs
    attr_hash = Hash[*attrs.flatten]
    if ['body', 'title', 'h1', 'h2', 'p', 'img'].include? name
      case name
        when 'title'
          @last_element_output_text = ":pageTitle:"
        when 'body'
          puts ":body:"
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
          @last_element_type = 'img'
          @img_counter += 1
          puts "  image_#{@img_counter}:"
          puts "    :src: \"#{attr_hash['src'].downcase}\""
          puts "    :alt: \"#{attr_hash['alt']}\"" 
          puts "    :id: \"#{attr_hash['id']}\"" 
          puts "    :width: \"#{attr_hash['width']}\""
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
      puts "#{@last_element_output_text} #{string}"
    end
  end
  
end		

Dir.glob(Dir.pwd+'/*.html').sort.each do |f|
  filename = File.basename(f, File.extname(f))
  page = Nokogiri::HTML(open(f))	
  xml_page = page.to_xhtml
  sax_parser = Nokogiri::XML::SAX::Parser.new(Article.new)
  sax_parser.parse(xml_page)
end
