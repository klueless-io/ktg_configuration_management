# frozen_string_literal: true

module KtgConfigurationManagement
  module DocumentUsecase
    # Outcome
    class KtgOutcome
      attr_reader :description
      attr_reader :extra
      attr_reader :sample

      def initialize(example)
        @description = example.description
        @extra = example.metadata[:extra] if example.metadata[:extra]
        @sample = example.metadata[:sample] if example.metadata[:sample]
      end

      def printable
        @sample != ''
      end

      def print
        puts "  #{description}"
        extra&.split("\n")&.each { |line| puts "    #{line.strip}" }
      end
    end
  end
end
