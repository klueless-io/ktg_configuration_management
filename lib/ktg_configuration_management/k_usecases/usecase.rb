# frozen_string_literal: true
# frozen_string_literal: true

module KtgConfigurationManagement
  module KUsecases
    # KTG Document
    class Usecase
      attr_reader :key
      attr_reader :description
      attr_reader :usage
      attr_reader :outcomes
      attr_reader :content_list
      attr_reader :source

      def initialize(key)
        @key = key
        @description = ''
        @usage = ''
        @outcomes = []
        @content_list = []
        @source = ''
        @content_hash = {}
      end

      def printable
        @usage != ''
      end

      def print
        puts description
        puts
        puts 'Usage:'
        puts "  #{usage}"
        puts
        puts 'Expected Outcomes:'
        outcomes.each(&:print)
        puts
        content_list.each(&:print)
        puts '-' * 120
      end

      def add_content(group)
        return if group.metadata[:content].nil? && !group.metadata[:content].is_a?(Array)

        group.metadata[:content].each do |content|
          key = "#{content[:label]}_#{content[:description]}"
          next if @content_hash.key?(key)

          @content_hash[key] = true
          content_list << KtgContent.new(content)
        end
      end

      def build_usage(example)
        @usage = example.metadata[:usage] if example.metadata[:usage]
      end

      def add_outcome(example)
        @outcomes << KtgOutcome.new(example) if example.description
      end

      def build_usage_description(example)
        return if description != ''

        if example.metadata[:title]
          @description = example.metadata[:title]
        else
          example.example_group.parent_groups.reverse.each do |group|
            @description = if @description.length.zero?
                             group.description
                           else
                             "#{@description} #{group.description}"
                           end
          end
        end
      end
    end
  end

  include KtgConfigurationManagement::KUsecases

end
