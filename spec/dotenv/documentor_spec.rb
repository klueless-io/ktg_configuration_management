# frozen_string_literal: true

require 'dotenv'

RSpec.describe Dotenv,
               :usecases,
               :jsonX,
               :debugX,
               :markdownX,
               :markdown_prettier,
               :markdown_open,
               markdown_file: 'docs/dotenv/documentor.md',
               document_title: 'Sample documentor',
               document_description: 'Descrition to go with this documentor' do
  describe 'load' do
    subject { described_class.load }

    usecase 'Default title',
            usage: "#{described_class.name}.load",
            usage_description: "#{described_class.name}.load will do blah blah" do
      it 'This is the expected outcome' do
      end
    end

    usecase 'Overwrite the title',
            usage: "#{described_class.name}.load",
            title: 'Default.load will load your application configuration from your `.env` file found in the project root:' do
      it 'This is an expected outcome' do
      end
      it 'This is another expected outcome' do
      end
    end
  end
end
