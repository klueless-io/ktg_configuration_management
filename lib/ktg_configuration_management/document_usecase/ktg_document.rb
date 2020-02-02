
module KtgConfigurationManagement
  module DocumentUsecase
    class KtgDocument
      attr_reader :key
      attr_reader :description
      attr_reader :sample
      attr_reader :outcomes
      attr_reader :source

      def initialize(key)
        @key = key
        @description = ''
        @sample = ''
        @outcomes = []
        @source = ''
      end

      def printable
        @sample != ''
      end

      def print
        puts self.description
        puts
        puts "Usage:"
        puts "  #{self.sample}"
        puts
        puts "Expected Outcomes:"
        outcomes.each { |o| o.print }
        puts
        if @source
          puts "Source:"
          puts
          puts source
          puts
        end
        puts '-' * 120
      end

      def set_sample(example)
        @sample = example.metadata[:sample] if example.metadata[:sample]
      end


      def set_source(example)
        @source = example.metadata[:source] if example.metadata[:source]
      end

      def add_outcome(example)
        @outcomes << KtgOutcome.new(example) if example.description
      end

      def set_description(example)
        return unless self.description == ''

        if example.metadata[:title]
          @description = example.metadata[:title]
        else
          example.example_group.parent_groups.reverse.each do |group|
            if @description.length == 0
              @description = group.description
            else
              @description = "#{@description} #{group.description}" 
            end
          end
        end
      end
    end
  end
end