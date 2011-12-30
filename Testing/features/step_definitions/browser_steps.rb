require 'net/http'

event1 = <<event1
:pageTitle: Event 1
:body:
  h1_1: Event 1
event1

event2 = <<event2
:pageTitle: Event 2
:body:
  h1_1: Event 2
event2

TestingSupport::Persona.all.each do |persona|
  Given /^#{persona.first_name} creates two events for the month of (.*)$/ do |month|
  create_event event1,"/event/1999/#{Date::MONTHNAMES.index(month)}/01"
  persona.store.put_event event1, '1999', Date::MONTHNAMES.index(month), '01'
  create_event event2,"/event/1999/#{Date::MONTHNAMES.index(month)}/02"
  persona.store.put_event event2, '1999', Date::MONTHNAMES.index(month), '02'
  end

  Given /^#{persona.first_name} creates two events for the year of (\d+)$/ do |year|
    create_event event1,"/event/#{year}/01/01"
    persona.store.put_event event1, year, '01', '01'
    create_event event2,"/event/#{year}/01/02"
    persona.store.put_event event2, year, '01', '02'
  end

  When /^#{persona.first_name} requests events in the month of (.*)$/ do |month|
    persona.browser.goto "#{APP_BASE_URL}/event/1999/#{Date::MONTHNAMES.index(month)}"
  end

  Then /^#{persona.first_name} should be returned only the two events created for the month of (.*)$/ do |month|
    persona.browser.title.should == "The events of #{month} 1999"

    expected_h1s = []
    persona.store.get_all_events_for_year_and_month('1999', '10').select do |key, value|
      expected_h1s << value[:body].values_at('h1_1')
    end

    actual_h1s= []
    persona.browser.h1s.each{|h1| actual_h1s << h1.text}

    actual_h1s.should =~ expected_h1s.flatten
  end

  When /^#{persona.first_name} requests events in the year of (\d+)$/ do |year|
    persona.browser.goto "#{APP_BASE_URL}/event/#{year}"
  end

  Then /^#{persona.first_name} should be returned only the two events created in the year (\d+)$/ do |year|
    persona.browser.title.should == "The events of #{year}"

    expected_h1s = []
    persona.store.get_all_events_for_year('1999').select do |key, value|
      expected_h1s << value[:body].values_at('h1_1')
    end

    actual_h1s= []
    persona.browser.h1s.each{|h1| actual_h1s << h1.text}

    actual_h1s.should =~ expected_h1s.flatten
  end
end

def create_event(content_in_yaml, url)
  uri = URI.parse APP_BASE_URL
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Put.new(url)
  request.body = content_in_yaml
  response = http.request request
  response.code.should == '200'
end