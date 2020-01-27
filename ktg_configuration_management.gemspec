# frozen_string_literal: true

require_relative 'lib/ktg_configuration_management/version'

Gem::Specification.new do |spec|
  spec.name          = 'ktg_configuration_management'
  spec.version       = KtgConfigurationManagement::VERSION
  spec.authors       = ['David']
  spec.email         = ['david@ideasmen.com.au']

  spec.summary       = 'ktg_configuration_management helps understanding of 3rd party gems that solve the problem of Configuration Management by working through different usecases with code examples and investigation of the code inside specific gems'
  spec.description   = 'ktg_configuration_management helps understanding of 3rd party gems that solve the problem of Configuration Management by working through different usecases with code examples and investigation of the code inside specific gems'
  spec.homepage      = 'http://appydave.com/know-thy-gem/ktg_configuration_management'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)

  # spec.metadata['allowed_push_host'] = "Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/klueless-io/ktg_configuration_management'
  spec.metadata['changelog_uri'] = 'https://github.com/klueless-io/ktg_configuration_management/commits/master'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the RubyGem files that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.extensions    = ['ext/ktg_configuration_management/extconf.rb']

  # spec.add_dependency 'tty-box',         '~> 0.5.0'
end
