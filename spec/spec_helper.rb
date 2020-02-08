# frozen_string_literal: true

require 'pry'
require 'bundler/setup'
require 'ktg_configuration_management'

Dir.chdir('lib') do
  Dir['ktg_configuration_management/document_usecase/*.rb'].sort.each { |file| require file }
end
Dir.chdir('lib') do
  Dir['ktg_configuration_management/k_usecases/*.rb'].sort.each { |file| require file }
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

  # ----------------------------------------------------------------------
  # Usecase Documentator
  # ----------------------------------------------------------------------

  config.alias_example_group_to :usecase, usecase: true

  config.extend KtgConfigurationManagement::DocumentUsecase
  # config.include KtgConfigurationManagement::DocumentUsecase
  config.before(:context, :usecases) do
    # puts self.class.children
    # puts self.class.children.first.children
    # puts self.class.descendants
    # puts self.class.descendants.first.metadata
    # puts self.class.filtered_examples
    # puts self.class.parent_groups

    @usecases = KtgConfigurationManagement::Usecases.new(self.class)
    @usecases.debug
  end

  # Know thy Gem documentor
  config.before(:all, :ktg) do
    @documentor = KtgConfigurationManagement::DocumentUsecase::KtgDocumentor.new

    # The following are all accessible from here
    #
    # self.class.children
    # self.class.children.first.children
    # self.class.descendants
    # self.class.descendants.first.metadata
    # self.class.filtered_examples
    # self.class.parent_groups
    #
    # See more: https://github.com/rspec/rspec-core/blob/master/lib/rspec/core/example_group.rb#L450
  end

  config.after(:context) do
  end

  config.after(:all, :ktg, :print) do
    @documentor.print
  end

  config.after(:each) do |example|
    next unless @documentor

    document = @documentor.get_document(example)

    if document
      document.build_usage_description(example)
      document.build_usage(example)
      document.add_outcome(example)
      document.add_content(example)
    end
  end
end

def fixture_path(gem_name, name)
  File.join(File.expand_path("../fixtures/#{gem_name}", __FILE__), name)
end

