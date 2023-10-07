module Rubidity
  module Module
    module Simulacrum
      MAJOR = 0
      MINOR = 1
      PATCH = 2
      VERSION = [MAJOR,MINOR,PATCH].join('.')
    
      def self.version
        VERSION
      end
    
      def self.banner
        "rubidity-simulacrum/#{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}] in (#{root})"
      end
    
      def self.root
        File.expand_path( File.dirname(File.dirname(File.dirname(File.dirname(__FILE__)))) )
      end
    
    end # module Simulacrum
  end # module Module
end # module Rubidity