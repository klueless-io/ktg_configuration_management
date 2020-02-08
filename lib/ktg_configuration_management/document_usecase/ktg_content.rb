# frozen_string_literal: true

module KtgConfigurationManagement
  module DocumentUsecase
    # Content block
    class KtgContent
      attr_reader :label
      attr_reader :description

      def initialize(content)
        @label = content[:label] || ''
        @description = content[:description] || ''
      end

      def print
        puts "#{label}:"
        description.split("\n").each { |line| puts "  #{line.chomp}" }
        puts
      end
    end
  end
end
