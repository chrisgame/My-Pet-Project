module MyPetProject
  class << self
    attr_accessor :process_id
  end
  module AppClient
    class << self
      def start
        $my_pet_project_log_file = File.new("#{ROOT_DIR}/thin.log", 'a')
        `thin -R #{ROOT_DIR}/config.ru -e local start`
      end

      def stop
        kill_all 'My-Pet-Project-App'
      end

      def kill_all process_name
        Process.kill(9, process_id(process_name)) unless process_id(process_name) == 0
      end

      def process_id process_name
        `ps aux | grep '#{process_name}' | grep -v grep`.strip.split(' ')[1].to_i
      end
    end
  end
end