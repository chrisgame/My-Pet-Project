require 'watir-webdriver'

TESTING_DIR = "#{File.dirname(__FILE__)}/../../"
TESTING_STORE_DIR = "#{TESTING_DIR}/features/support/store"
ROOT_DIR = "#{TESTING_DIR}/.."
ROOT_STORE_DIR = "#{ROOT_DIR}/store"
APP_BASE_URL = 'http://localhost:3000'

def clear_down(path)
  FileUtils.rm_rf path if File.exists? path
  FileUtils.mkdir_p path
end

Before do |scenario|
  SCENARIO = scenario.gherkin_statement.name

  clear_down TESTING_STORE_DIR
  clear_down ROOT_STORE_DIR

  puts "Tests are running against #{APP_BASE_URL}"
  puts "This test run was brought to you by #{Persona.first_names}"
end

After do
 Persona.all.each{|persona| persona.close_browser}
end