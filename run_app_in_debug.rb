ENV['RACK_ENV'] = 'debug'
def run param

end

load "#{File.dirname(__FILE__)}/config.ru"

MyPetProject.run!