  module MyPetProject
  class << self
    attr_reader :base_url

    def configure base_url
      @base_url = base_url
    end
  end
end

