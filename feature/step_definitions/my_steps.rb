require 'rspec'

Given /^i am on the homepage$/ do
  $browser.goto('www.google.com')
end
Given /^i make a (put|get) request (to|on) '(.*)' with a payload of$/ do |http_method, syntax_sugar, url, payload|
  uri = URI.parse 'http://localhost:4567'
  case http_method
    when 'put'
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Put.new(url)
      request.body = payload
      response = http.request request
      response.code.should == '200'
  end
end
When /^i make a (get|put) request on '(.*)'$/ do |http_method, url|
  uri = URI.parse 'http://localhost:4567'
  http = Net::HTTP.new(uri.host, uri.port)
  case http_method
    when 'get'
      request = Net::HTTP::Get.new(url)
      $last_response = http.request request
      $last_response.code.should == '200'
  end
end
Then /^the page title should be '(.*)'$/ do |page_title|
  groups = $last_response.body.partition /<title>(.*)\<\/title\>/m
  groups[1].should == "<title>#{page_title}</title>"
  $last_response.body = groups[2]
end
When /^the next element should be a (h1|p) containing '(.*)'$/ do |html_type, expected_contents|
  case html_type
    when 'h1'
      groups = $last_response.body.partition /.*\<h1\>(.*)\<\/h1\>/
      groups[1].strip.should  == "<h1>#{expected_contents}</h1>"
      $last_response.body = groups[2]
    when 'p'
      groups = $last_response.body.partition /.*\<p\>(.*)\<\/p\>/
      groups[1].strip.should ==  "<p>#{expected_contents}</p>"
      $last_response.body = groups[2]
  end
end
When /^the next element should be a (img) with the following attributes$/ do |tag_type, table|
  # table is a |alt|Front and centre sections of the car loaded on the truck|
  case tag_type
    when 'img'
      groups = $last_response.body.partition /^.*\<img(.*)\/\>/m
      table.raw[0][1].should == groups[1][/alt='(.*)' id.*/,1]
      table.raw[1][1].should == groups[1][/id='(.*)' src.*/,1]
      table.raw[2][1].should == groups[1][/src='(.*)' width.*/,1]
      table.raw[3][1].should == groups[1][/width='(.*)'.*\/\>.*/,1]
  end

end