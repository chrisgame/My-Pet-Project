TestingSupport::Persona.all.each do |persona|
  When /^#{persona.first_name} requests events in the month of (.*)$/ do |month|
    persona.browser.goto "#{APP_BASE_URL}/event/1999/#{Date::MONTHNAMES.index(month)}"
  end

  When /^#{persona.first_name} requests events in the year of (\d+)$/ do |year|
    persona.browser.goto "#{APP_BASE_URL}/event/#{year}"
  end

  Given /^#{persona.first_name} requests events from (.*) (\d+)/ do |month, day|
    persona.browser.goto "#{APP_BASE_URL}/event/#{month}/#{day}"
  end
end
