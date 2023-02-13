# frozen_string_literal: true

require_relative 'lib/schedjewel/version'

Gem::Specification.new do |spec|
  spec.name          = 'schedjewel'
  spec.version       = Schedjewel::VERSION
  spec.authors       = ['David Runger']
  spec.email         = ['davidjrunger@gmail.com']

  spec.summary       = 'Run Sidekiq jobs on a schedule'
  spec.homepage      = 'https://github.com/davidrunger/schedjewel'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://davidrunger.com'
    spec.metadata['rubygems_mfa_required'] = 'true'

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/davidrunger/schedjewel'
    spec.metadata['changelog_uri'] = 'https://github.com/davidrunger/schedjewel/blob/master/CHANGELOG.md'
  else
    raise('RubyGems 2.0 or newer is required to protect against public gem pushes.')
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files =
    Dir.chdir(File.expand_path(__dir__)) do
      `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
    end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency('memoist', '~> 0.16')
  spec.add_dependency('redis', '~> 5.0')
  spec.add_dependency('redlock', '>= 1.3', '< 3.0')

  spec.required_ruby_version = '>= 3.1'
end
