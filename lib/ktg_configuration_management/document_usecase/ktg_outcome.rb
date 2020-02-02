
module KtgConfigurationManagement
  module DocumentUsecase
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
        puts "  #{self.description}"
        extra.split("\n").each { |line| puts "    #{line.strip}"} if self.extra
        # if self.sample
        #   puts
        #   puts "    #{self.sample}"
        # end
      end

      # def set_sample(example)
      #   @sample = example.metadata[:sample] if example.metadata[:sample]
      # end

      # def set_description(example)
      #   return unless self.description == '' 

      #   example.example_group.parent_groups.reverse.each do |group|
      #     if @description.length == 0
      #       @description = group.description
      #     else
      #       @description = "#{@description} #{group.description}" 
      #     end
      #   end

      # end
    end
  end
end