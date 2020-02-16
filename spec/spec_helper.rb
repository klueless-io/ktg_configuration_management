# frozen_string_literal: true

require 'bundler/setup'
require 'k_usecases'
require 'ktg_configuration_management'
require 'pry'

# Dir.chdir('lib') do
#   Dir['ktg_configuration_management/document_usecase/*.rb'].sort.each { |file| require file }
# end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'
  config.filter_run_when_matching :focus

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # ----------------------------------------------------------------------
  # Usecase Documentator
  # ----------------------------------------------------------------------

  KUsecases.configure(config)

  config.before(:context, :usecases) do
    @documentor = KUsecases::Documentor.new(self.class)
  end

  config.after(:context, :usecases) do
    @documentor.render
  end
end

def fixture_path(gem_name, name)
  File.join(File.expand_path("../fixtures/#{gem_name}", __FILE__), name)
end
