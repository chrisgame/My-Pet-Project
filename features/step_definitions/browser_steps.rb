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

def create_event(content_in_yaml, url)
  uri = URI.parse APP_BASE_URL
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Put.new(url)
  request.body = content_in_yaml
  response = http.request request
  response.code.should == '200'
end

def create_event_and_store_in_persona persona, content_in_yaml, year, month, day
  create_event content_in_yaml, "/event/#{year}/#{month}/#{day}"
  persona.event_store.put_event content_in_yaml, year, month, day
end

TestingSupport::Persona.all.each do |persona|
  Given /^#{persona.first_name} creates an event for (\d+)\/(\d+)\/(\d+)/ do |day, month, year|
    create_event_and_store_in_persona persona, event1, year, month, day
  end

  Given /^#{persona.first_name} creates two events for the month of (.*)$/ do |month|
    create_event_and_store_in_persona persona, event1, 1999, Date::MONTHNAMES.index(month), '01'
    create_event_and_store_in_persona persona, event2, 1999, Date::MONTHNAMES.index(month), '02'
  end

  Given /^#{persona.first_name} creates two events for the year of (\d+)$/ do |year|
    create_event_and_store_in_persona persona, event1, year, '01', '01'
    create_event_and_store_in_persona persona, event2, year, '01', '02'
  end



  Then /^#{persona.first_name} should be returned only the two events created for the month of (.*)$/ do |month|
    persona.browser.title.should == "The events of #{month} 1999"

    expected_h1s = []
    persona.event_store.get_all_events_for_year_and_month('1999', '10').select do |key, value|
      expected_h1s << value[:body].values_at('h1_1')
    end

    actual_h1s= []
    persona.browser.h1s.each { |h1| actual_h1s << h1.text }

    actual_h1s.should =~ expected_h1s.flatten
  end

  Then /^#{persona.first_name} should be returned only the two events created in the year (\d+)$/ do |year|
    persona.browser.title.should == "The events of #{year}"

    expected_h1s = []
    persona.event_store.get_all_events_for_year('1999').select do |key, value|
      expected_h1s << value[:body].values_at('h1_1')
    end

    actual_h1s= []
    persona.browser.h1s.each { |h1| actual_h1s << h1.text }

    actual_h1s.should =~ expected_h1s.flatten
  end

  When /^#{persona.first_name} should see the (event|events) created in the timeline$/ do |unused|
    persona.browser.goto "#{APP_BASE_URL}/timeline"

    expected_titles = []
    persona.event_store.get_timeline.each do |month_and_year, days|
      days.each do |day|
        expected_titles << day[:title]
      end
    end

    actual_titles= []
    persona.browser.elements(:class => 'tl-msg-inside').each { |title| actual_titles << title.text }

    actual_titles.should =~ expected_titles.flatten
  end

  When /^#{persona.first_name} clicks on the title for the event on (\d+)\/(\d+)\/(\d+)/ do |day, month, year|
    persona.browser.elements(:css => 'li#event-first-test-month.milestone a').each do |a|
      if a.attribute_value(:href) == "#{APP_BASE_URL}/event/#{year}/#{month}/#{day}"
        a.click
      end
    end
  end

  When /^#{persona.first_name} is on the timeline page$/ do
    persona.browser.goto "#{APP_BASE_URL}/timeline"
  end

  Then /^#{persona.first_name} should be taken to the article for the event on (\d+)\/(\d+)\/(\d+)/ do |day, month, year|
    persona.browser.title.should == persona.event_store.get_event_on_year_month_and_day(year, month, day)[:pageTitle]
  end

  Then /^#{persona.first_name} should see a message that states '(.*)'$/ do |message|
    persona.browser.text.should =~ /#{message}/
  end

  When /^#{persona.first_name} goes to '(.*)' the same image asset should be displayed$/ do |url|
    persona.browser.goto "#{APP_BASE_URL}#{url}"
    #TODO Take screenshot here
  end

  Given /^#{persona.first_name} uploads an image asset with a filename of '(.*)'$/ do |filename|
    persona.browser.goto "#{APP_BASE_URL}/upload"
    persona.browser.file_field.set "#{File.dirname(__FILE__)}/../support/assets/#{filename}"
    persona.browser.button(:name => 'upload').click
    persona.browser.text.should == 'Correct!'

    persona.asset_store.save File.open("#{File.dirname(__FILE__)}/../support/assets/#{filename}", "rb"), filename
  end

  When /^#{persona.first_name} goes to '(.*)'$/ do |url|
    persona.browser.goto "#{APP_BASE_URL}#{url}"
  end

  Then /^#{persona.first_name} should see only the assets he uploaded earlier$/ do
    expected_assets = persona.asset_store.get_all_assets.collect{|relative_asset_path| "#{APP_BASE_URL}/#{relative_asset_path}"}

    actual_images = []
    persona.browser.imgs.each{|img| actual_images << img.src}

    actual_images.should == expected_assets
    #TODO Take screenshot here
  end
end
