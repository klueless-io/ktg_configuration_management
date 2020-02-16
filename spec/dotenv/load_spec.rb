# frozen_string_literal: true

require 'dotenv'

RSpec.describe Dotenv,
               :usecases,
               :jsonX,
               :debugX,
               :markdownX,
               :markdown_prettier,
               :markdown_open,
               markdown_file: 'docs/dotenv/load.md',
               document_title: 'Load environment variables from `.env`',
               document_description: 'Samples and use cases for working with `dotenv` gem via the load method' do
  describe 'load' do
    subject { described_class.load(*config_file_paths) }

    let(:config_files) { [] }
    let(:config_file_paths) { config_files.map { |f| fixture_path('dotenv', f) } }

    src_folder = '/Users/davidcruwys/dev/gems_3rd/dotenv'
    src_dotenv = File.join(src_folder, 'lib/dotenv.rb')

    usecase 'Basic app configuration load',
            title: 'Load from default .env file',
            usage: "#{described_class.name}.load",
            usage_description: 'Default.load will load application configuration from your `.env` file found in the project root' do
      ruby 'returns a hash with environment values'  do # , block_id: 1,
        # code: uc_block_content(1, File.read('spec/dotenv/load_spec.rb'), 'returns a hash with environment values')
        is_expected.to eq('DOTENV' => 'true')
      end
    end

    #   it 'updates ENV["variables"] with environment values',
    #      extra: "
    #       Whenever your application loads, the variables listed in .env will be available in ENV:

    #       ```ruby
    #       config.fog_directory  = ENV['S3_BUCKET']
    #       ```" do
    #     subject
    #     expect(ENV['DOTENV']).to eq('true')
    #   end
    # end

    #   xusecase 'with simple key/values',
    #            usage: "#{described_class.name}.load('simple.env')",
    #            content: [{
    #              label: 'Source',
    #              description: uc_file_content(src_dotenv, lines: [5, *(12..19), 85], code_type: 'ruby')
    #            }] do
    #     let(:config_files) { ['simple.env'] }

    #     it 'set simple environment variables',
    #        extra: "
    # Standand name/value pair environement variables:

    # #{uc_file_content(fixture_path('dotenv', 'simple.env'), lines: [0, 1], code_type: 'bash')}
    #     " do
    #       subject
    #       expect(ENV['KEY1']).to eq('key1')
    #       expect(ENV['KEY2']).to eq('key2')
    #     end

    #     it 'supports exported environment variables',
    #        extra: "
    # You may add export in front of each line so you can source the file in bash:

    # #{uc_file_content(fixture_path('dotenv', 'simple.env'), lines: [*(3..5)], code_type: 'bash')}" do
    #       subject
    #       expect(ENV['S3_BUCKET']).to eq('YOURS3BUCKET')
    #       expect(ENV['SECRET_KEY']).to eq('YOURSECRETKEYGOESHERE')
    #     end
    #   end

    #   xusecase 'with multiline values',
    #            usage: "#{described_class.name}.load('multiline.env')",
    #            content: [{
    #              label: 'Example',
    #              description: uc_file_content(fixture_path('dotenv', 'multiline.env'), code_type: 'bash')
    #            }] do
    #     let(:config_files) { ['multiline.env'] }

    #     it 'set environment variable with values mixed with line feeds' do
    #       is_expected.to include('MULTI_LINE_KEY1' => "-----BEGIN RSA PRIVATE KEY-----\nKEY-1\n-----END DSA PRIVATE KEY-----\n")
    #     end

    #     it 'set environment variable with multiline values' do
    #       is_expected.to include('MULTI_LINE_KEY1' => "-----BEGIN RSA PRIVATE KEY-----\nKEY-1\n-----END DSA PRIVATE KEY-----\n")
    #     end
    #   end

    #   xusecase 'with quoted values',
    #            usage: "#{described_class.name}.load('quoted.env')",
    #            content: [{
    #              label: 'Example',
    #              description: uc_file_content(fixture_path('dotenv', 'quoted.env'), code_type: 'bash')
    #            }, {
    #              label: 'Output',
    #              description: JSON.pretty_generate(described_class.load(fixture_path('dotenv', 'quoted.env')))
    #            }] do
    #     let(:config_files) { ['quoted.env'] }

    #     it 'converts all values to string' do
    #       expect(subject['QUOTED']).to eq 'true'
    #       expect(subject['OPTION_1']).to eq '1'
    #       expect(subject['OPTION_2']).to eq '2'
    #       expect(subject['OPTION_3']).to eq '3'
    #     end

    #     it 'handles empty values as \'\'' do
    #       expect(subject['BLANK_1']).to eq ''
    #       expect(subject['BLANK_2']).to eq ''
    #       expect(subject['BLANK_3']).to eq ''
    #     end

    #     it 'will escape single quote LF - \'\n\' to \'\\\n\'' do
    #       expect(subject['OPTION_G']).to eq '\\n\\n\\n'
    #     end

    #     it 'will not alter double quote LF - "\n"' do
    #       expect(subject['OPTION_H']).to eq "\n\n\n"
    #     end
    #   end

    #   xusecase 'with YAML file input',
    #            usage: "#{described_class.name}.load('yaml.env')",
    #            content: [{
    #              label: 'Example',
    #              description: uc_file_content(fixture_path('dotenv', 'yaml.env'), code_type: 'yaml')
    #            }, {
    #              label: 'Output',
    #              description: JSON.pretty_generate(described_class.load(fixture_path('dotenv', 'yaml.env')))
    #            }] do
    #     let(:config_files) { ['yaml.env'] }

    #     it 'will read simple YAML key/values' do
    #       expect(subject['OPTION_A']).to eq '1'
    #       expect(subject['OPTION_B']).to eq '2'
    #       expect(subject['OPTION_C']).to eq ''
    #     end

    #     it 'will escape single quote LF - \'\n\' to \'\\\n\'' do
    #       expect(subject['OPTION_D']).to eq '\\n'
    #     end

    #     it 'will not alter double quote LF - "\n"' do
    #       expect(subject['OPTION_E']).to eq "\n"
    #     end

    #     it 'will not handle YAML array types' do
    #       expect(subject['BLAH']).to eq '- VALUE1'
    #     end
    #   end
  end
end
