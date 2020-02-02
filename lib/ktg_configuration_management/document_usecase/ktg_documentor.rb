
module KtgConfigurationManagement
  module DocumentUsecase
    class KtgDocumentor
      attr_reader :documents

      # puts self.class.top_level_description
      # puts self.class.description
      # puts RSpec.current_example.description
      # # puts self.class.name
      # puts "#{self.class.top_level_description} #{self.class.description} #{RSpec.current_example.description}"
      # puts RSpec.current_example.metadata[:example_group][:parent_example_group][:parent_example_group]
      # # puts self.title
      # puts 'GO RICKY GOT RICK'
      # puts example.description
      # puts example

      def initialize
        @documents = []
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

      private

      def build_key(example)
        key = ''
        key = example.metadata[:sample] if example.metadata[:sample]
      end

      def get_document_by_key(key)
        @documents.find { |d| d.key == key }
      end

    end
  end
end