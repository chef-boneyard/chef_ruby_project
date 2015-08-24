$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'ruby_project_template'
require 'cheffish/rspec/chef_run_support'

RSpec.configure do |config|
  config.extend Cheffish::RSpec::ChefRunSupport
  config.filter_run(focus: true)
  config.run_all_when_everything_filtered = true

  config.before(:each) do
    Chef::Config.reset

    # By default, treat deprecation warnings as errors in tests.
    Chef::Config.treat_deprecation_warnings_as_errors(true)

    # Set environment variable so the setting persists in child processes
    ENV['CHEF_TREAT_DEPRECATION_WARNINGS_AS_ERRORS'] = "1"
  end
end
