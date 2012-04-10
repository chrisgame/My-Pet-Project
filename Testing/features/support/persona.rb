require 'ostruct'
load "#{File.dirname(__FILE__)}/../../../lib/eventstore.rb"
load "#{File.dirname(__FILE__)}/../../../lib/assetstore.rb"

module TestingSupport
  class Persona < OpenStruct
    class << self
      def << instance
        @instances ||= []
        @instances << instance
      end

      def all
        @instances
      end

      def first_names
        @instances.collect{ |persona| persona.first_name}
      end
    end

    def initialize &block
      super
      yield self if block_given?
      Persona << self
    end

    def event_store
      @event_store ||= EventStore::FileBasedEventStore.new do |store|
        Dir.chdir File.dirname(__FILE__)
      end
    end

    def asset_store
      @asset_store ||= AssetStore::FileBasedAssetStore.new do |store|
        Dir.chdir File.dirname(__FILE__)
      end
    end

    def browser
      Dir.chdir("#{File.dirname(__FILE__)}/../../")
      @browser ||= Watir::Browser.new
    end

    def close_browser
      if @browser
        @browser.close
        @browser = nil
      end
    end
  end

  Persona.new do |mo|
    mo.first_name = 'Mo'
  end

  Persona.new do |joe|
    joe.first_name = 'Joe'
  end

  Persona.all.each do |persona|
    persona_name = persona.first_name.downcase
    alias_personas_by_first_name= <<-METHOD
      def #{persona_name}
        Persona.all.find{|persona| persona.first_name == '#{persona.first_name}'}
      end
    METHOD
    eval alias_personas_by_first_name
  end
end

World(TestingSupport)