# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cnp_one_click/version'

Gem::Specification.new do |spec|
  spec.name          = 'cnp_one_click'
  spec.version       = CnpOneClick::VERSION
  spec.authors       = ['Pavel Tkachenko']
  spec.email         = ['tpepost@gmail.com']

  spec.summary       = %q{Easy integration with CNP Processing GmhH OneClick® services}
  spec.description   = %q{You will be able to use such functionality as card registration,
                          card managing, payments (including auto payments) and server
                          notifications from processing servers. }
  spec.homepage      = 'https://github.com/PavelTkachenko/cnp_one_click'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'capybara'
  spec.add_development_dependency 'selenium-webdriver'

  spec.add_runtime_dependency 'savon'
end
