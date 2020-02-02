# frozen_string_literal: true

require 'pry'
require 'bundler/setup'
require 'ktg_configuration_management'

# require 'ktg_configuration_management/document_usecase/ktg_documentor'
# require 'ktg_configuration_management/document_usecase/ktg_document'
# require 'ktg_configuration_management/document_usecase/ktg_outcome'

Dir.chdir('lib') do
  Dir["ktg_configuration_management/document_usecase/*.rb"].each {|file| require file }
end

RSpec.configure do |config|

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'
  config.filter_run_when_matching :focus

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.extend KtgConfigurationManagement::DocumentUsecase
  # config.include KtgConfigurationManagement::DocumentUsecase

  # Know thy Gem documentor
  config.before(:all, :ktg) do |example_group|
    @documentor = KtgConfigurationManagement::DocumentUsecase::KtgDocumentor.new 
  end
  config.after(:all, :ktg, :print) do |example_group|
    @documentor.print
  end

  config.after(:each) do |example|
    next unless @documentor

    document = @documentor.get_document(example)

    if document
      document.set_description(example)
      document.set_sample(example)
      document.add_outcome(example)
      document.set_source(example)
    end
  end
end

def fixture_path(gem_name, name)
  File.join(File.expand_path("../fixtures/#{gem_name}", __FILE__), name)
end

