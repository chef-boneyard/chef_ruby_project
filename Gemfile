source "https://rubygems.org"

# Specify your gem's dependencies in chef_ruby_project.gemspec
gemspec

# Allow Travis to run tests with different dependency versions
if ENV["GEMFILE_MOD"]
  instance_eval(ENV["GEMFILE_MOD"])
end
