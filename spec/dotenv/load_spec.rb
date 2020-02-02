# frozen_string_literal: true
require 'dotenv'
# RSpec.describe KtgConfigurationManagement::DotEnv::Load do
RSpec.describe Dotenv, :ktg, :print do

  describe 'load' do

    subject { described_class.load(*config_file_paths) }

    let(:config_files) { [] }
    let(:config_file_paths) { config_files.map { |f| fixture_path('dotenv', f) } }

    src_folder = '/Users/davidcruwys/dev/gems_3rd/dotenv'
    src_dotenv = File.join(src_folder, 'lib/dotenv.rb')

    fcontext 'from default .env file',
      sample: "#{described_class.name}.load",
      title: 'Default.load will load your application configuration from your `.env` file found in the project root:',
      source: "```ruby
#{uc_add_content(src_dotenv, lines: [5, *(12..19), 85])}
```" do

      it 'returns a hash with environment values' do
        is_expected.to eq('DOTENV' => 'true')
      end

      it 'updates ENV["variables"] with environment values',
        extra: %Q{
          Whenever your application loads, these variables will be available in ENV:

          ```ruby
          config.fog_directory  = ENV['S3_BUCKET']
          ```

          } do
        subject
        expect(ENV['DOTENV']).to eq('true')
      end
    end

    context 'with simple key/values', 
      sample: "#{described_class.name}.load('simple.env')" do

      let(:config_files) { ['simple.env'] }

      it 'set simple environment variables',
        extra: %Q{
  Standand name/value pair environement varialbles:
  
  ```
  #{uc_add_content(fixture_path('dotenv', 'simple.env'), lines: (0..1))}
  ```
      } do
        subject
        expect(ENV['KEY1']).to eq('key1')
        expect(ENV['KEY2']).to eq('key2')
      end

      it 'supports exported environment variables',
        extra: %Q{
  You may add  export in front of each line so you can source the file in bash:
  
  ```bash
  #{uc_add_content(fixture_path('dotenv', 'simple.env'), lines: (2..4))}
  ```
      } do
        subject
        expect(ENV['S3_BUCKET']).to eq('YOURS3BUCKET')
        expect(ENV['SECRET_KEY']).to eq('YOURSECRETKEYGOESHERE')
      end
    end

    context 'with multiline values', 
      sample: "#{described_class.name}.load('multiline.env')" do

      let(:config_files) { ['multiline.env'] }

      it 'set environment variable with values mixed with line feeds' do
        is_expected.to include('MULTI_LINE_KEY1' => "-----BEGIN RSA PRIVATE KEY-----\nKEY-1\n-----END DSA PRIVATE KEY-----\n")
      end

      it 'set environment variable with multiline values' do
        is_expected.to include('MULTI_LINE_KEY1' => "-----BEGIN RSA PRIVATE KEY-----\nKEY-1\n-----END DSA PRIVATE KEY-----\n")
      end
    end

  end
end
