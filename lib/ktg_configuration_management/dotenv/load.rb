# frozen_string_literal: true

require 'dotenv/load'

module KtgConfigurationManagement
  module DotEnv
    class Load

      def overload
      end
      def parse
      end
      def instrumentation
        # https://dev.to/hugodias/using-rails-secret-weapon-activesupportnotifications-12d3
      end

      # Default load will set the parsed in file name to .env
      # it is assumed that this file will exist in the application root
      def self.load
        # https://github.com/bkeepers/dotenv/blob/master/lib/dotenv.rb#L13
        # https://github.com/bkeepers/dotenv/blob/master/lib/dotenv.rb#L23
        # https://github.com/bkeepers/dotenv/blob/master/lib/dotenv.rb#L59
        result = Dotenv.load

        { 
          key1: ENV['KEY1'],
          key2: ENV['KEY2'],
          key3: ENV['KEY3'],
          cr_key1: ENV['CR_KEY1'],
          cr_key2: ENV['CR_KEY2'],
        }
      end

    end
  end
end
