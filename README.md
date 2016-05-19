# chef_ruby_project

[![Build Status Master](https://travis-ci.org/chef/chef_ruby_project.svg?branch=master)](https://travis-ci.org/chef/chef_ruby_project)
[![Build Status Master](https://ci.appveyor.com/api/projects/status/github/chef/chef_ruby_project?branch=master&svg=true&passingText=master%20-%20Ok&pendingText=master%20-%20Pending&failingText=master%20-%20Failing)](https://ci.appveyor.com/project/Chef/chef_ruby_project/branch/master)

This repository helps you get started making a Chef Ruby gem project.

Right now, it supports rake tasks. To use it, `add_development_dependency "chef_ruby_project"` to your gemspec, and put this in your Rakefile:

```ruby
require "chef_ruby_project"

ChefRubyProject.define_rake_tasks do
  multitask "default" => %w{spec style}
  gem_tasks "build", "install", "release"
  chefstyle_task "style"
  changelog_task "changelog"
  rspec_task "spec"
  yard_task "yard:html"
  task "yard" => "yard:html"
end
```

This will generate a Rakefile with Chef-standard tasks for `default`, `build`, `install`, `release`. As we learn more and add capability to the tasks, all projects using this will gain the fixes.

As we progress, this will support multiplatform gemspecs, version and dependency updating, and the generation of template projects with yard documentation, default specs, kitchen and travis support, and proper chefstyle support.

# DEVELOPMENT:

Before working on the code, if you plan to contribute your changes, you
should read the contributing guidelines:

* https://github.com/chef/chef_ruby_project/blob/master/CONTRIBUTING.md

The basic process for contributing is:

1. Fork this repo on GitHub.
2. Create a feature branch for your work.
3. Make your change, including tests.
4. Submit a pull request.

## Spec Testing:

We use RSpec for unit/spec tests. To run the full suite, run:

    bundle exec rake spec

You can run individual test files by running the rspec executable:

    bundle exec rspec spec/unit/FILE.rb

## Rake Tasks

This project has some Rake tasks for doing various things.

    rake -T
    rake # spec and style
    rake build # build all platforms of pkg/chef_ruby_project-VERSION[-PLATFORM].gem
    rake install # build, then install the current platform chef_ruby_project into the current ruby
    rake release # build and release all platforms of chef_ruby_project to rubygems.org
    rake spec # run the specs
    rake style # run chefstyle
    rake yard # generate yard documentation
    rake changelog # generate changelog

    ($VERSION is the current version, from the GemSpec in Rakefile)

# RELEASING

To release a new version:

1. Ensure the CHANGELOG is up to date.
2. Ship DOC_CHANGES (put the docs wherever they belong) and empty it out.
3. Update the version number in `version.rb`
4. `bundle exec rake release` (this will create a git tag for the version, push git commits and tags, and build and push the `.gem` file to [rubygems.org](https://rubygems.org)

# LINKS:

Source:

* http://github.com/chef/chef_ruby_project/tree/master

Issues:

* https://github.com/chef/chef_ruby_project/issues

# LICENSE:

<Ruby Project Template> - a chef project

* Author:: Your Name (<your_name@chef.io>)
* Copyright:: Copyright (c) 2008-2015 Chef Software, Inc.
* License:: Apache License, Version 2.0

```text
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
