require 'watir-webdriver'

Before do
  $browser ||= Watir::Browser.new
end

After do
  $browser.close
end