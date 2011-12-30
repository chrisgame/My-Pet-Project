require 'rspec'
require 'net/http'

Given /^i make a put request on '(.*)' with the following payload a '(\d+)' should be returned$/ do |url, http_response_code, payload|
  uri = URI.parse APP_BASE_URL

  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Put.new(url)
  request.body = payload
  response = http.request request
  response.code.should == http_response_code
end
When /^i make a get request on '(.*)' a '(\d+)' should be returned$/ do |url, http_response_code|
  uri = URI.parse APP_BASE_URL
  http = Net::HTTP.new(uri.host, uri.port)

  request = Net::HTTP::Get.new(url)
  $last_response = http.request request
  $last_response.code.should == http_response_code
end
Then /^the page title should be '(.*)'$/ do |page_title|
  groups = $last_response.body.partition /<title>(.*)\<\/title\>/m
  groups[1].should == "<title>#{page_title}</title>"
  $last_response.body = groups[2]
end
When /^the next element should be a (h1|p) containing '(.*)'$/ do |html_type, expected_contents|
  case html_type
    when 'h1'
      groups = $last_response.body.partition /.*\<h1\>(.*)\<\/h1\>.*/
      groups[1].strip.should  == "<h1>#{expected_contents}</h1>"
      $last_response.body = groups[2]
    when 'p'
      groups = $last_response.body.partition /.*\<p\>(.*)\<\/p\>.*/
      groups[1].strip.should ==  "<p>#{expected_contents}</p>"
      $last_response.body = groups[2]
  end
end
When /^the next element should be a (img) with the following attributes$/ do |tag_type, table|
  # table is a |alt|Front and centre sections of the car loaded on the truck|
  case tag_type
    when 'img'
      groups = $last_response.body.partition /^.*\<img(.*)\/\>/m
      groups[1][/alt='(.*)' id.*/, 1].should == table.raw[0][1]
      groups[1][/id='(.*)' src.*/, 1].should == table.raw[1][1]
      groups[1][/src='(.*)' width.*/, 1].should == table.raw[2][1]
      groups[1][/width='(.*)'.*\/\>.*/, 1].should == table.raw[3][1]
  end

end
Given /^a put request is made on '(.*)' with an image asset a response code of '(.*)' should be returned$/ do  |path, response_code|
  uri = URI.parse APP_BASE_URL
  http = Net::HTTP.new(uri.host, uri.port)

  data = File.read "#{File.dirname(__FILE__)}/../support/assets/test.jpeg"

  response, body = http.put(path, data, {'Content-type' => 'image/jpeg'})

  response.code.should == response_code
end
When /^a get request is made on the store with the following '(.*)' the same image asset should be returned with a response code of '(.*)'$/ do |path, response_code|
  uri = URI.parse @STORE_BASE_URL
  http = Net::HTTP.new(uri.host, uri.port)

  response, body = http.get(path)

  response.code.should == response_code
end
