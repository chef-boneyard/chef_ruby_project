# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_project_template/version'

Gem::Specification.new do |spec|
  spec.name = 'ruby-project-template'
  spec.summary       = %q{TODO: Write a short summary, because Rubygems requires one.}
  spec.description = spec.summary
  spec.homepage = "https://chef.io"
  spec.author = "Your Name"
  spec.email = "your_name@chef.io"
  spec.version = ProjectName::VERSION
  spec.platform = Gem::Platform::RUBY
  spec.license = "Apache-2.0"

  spec.required_ruby_version = ">= 2.0.0"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "cheffish", "~> 1.3"
  spec.add_development_dependency "pry"

  spec.extra_rdoc_files = ["README.md", "CONTRIBUTING.md", "LICENSE" ]
  spec.files = %w(Rakefile LICENSE README.md CONTRIBUTING.md) + Dir.glob("{distro,lib,tasks,spec,exe}/**/*", File::FNM_DOTMATCH).reject {|f| File.directory?(f) }
  spec.bindir       = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end
end
