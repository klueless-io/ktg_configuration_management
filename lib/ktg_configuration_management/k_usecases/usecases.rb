# frozen_string_literal: true

module KtgConfigurationManagement
  module KUsecases
    # List of usecases to document
    class Usecases
      attr_reader :usecases

      # The following are all accessible from here
      #
      # self.class.children
      # self.class.children.first.children
      # self.class.descendants
      # self.class.descendants.first.metadata
      # self.class.filtered_examples
      # self.class.parent_groups
      # puts self.class.top_level_description
      # puts self.class.description
      # puts RSpec.current_example.description
      # puts self.class.name
      # puts "#{self.class.top_level_description} #{self.class.description} #{RSpec.current_example.description}"
      # puts RSpec.current_example.metadata[:example_group][:parent_example_group][:parent_example_group]
      # puts self.title
      # puts example.description

      def initialize(root_example_group)
        @usecases = {}

        # puts root_example_group

        build_usecases(root_example_group)
      end

      def get_document(example)
        key = build_key(example)

        return nil if key == ''

        document = get_document_by_key(key)
        if document.nil?
          document = KtgDocument.new(key)
          @documents << document
        end
        document
      end

      def print
        puts '=' * 120
        self.documents.select{ |d| d.printable }.each { |d| d.print }
      end

      def debug
        puts 'x' * 70
        puts @usecases.map(&:debug)
        puts 'x' * 70
      end

      private

      def build_usecases(root_example_group)
        usecases = root_example_group.descendants.select { |d| d.metadata[:usecase] == true }
        # puts usecases

        @usecases = usecases.map { |uc| build_usecase(uc) }
      end

      def build_usecase(data)
        key = data.name

        @usecases[key] if @usecases.key?(key)

        usecase = Usecase.new(key)
        @usecases[key] = usecase
      end
      

    end
  end
  
  include KtgConfigurationManagement::KUsecases
end
