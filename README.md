# ruby-project-template

This repository helps you get started making a Chef Ruby gem project.

To get started:

1. Replace the project name in different files. For example, if your project is `my-awesome-project`, replace `<Ruby Project Template>` with `My Awesome Project`, `ruby-project-template` with `my-awesome-project` and `ruby_project_template` with `my_awesome_project`.
2. Rename `ruby_project_template.gemspec`, `spec/ruby_project_template.rb`, `lib/ruby_project_template` and `lib/ruby_project_template.rb` as well.
3. Replace your name and email in different files. For example, replace `<Your Name>` with `John Keiser` and `your_name@chef.io` with `jkeiser@chef.io
4. Make your Slack channel notification and modify `.travis.yml` to include it.
5. Add your project to Travis.
6. Add your project to Appveyor if applicable (remove the appveyor line if not).
7. Remove this header from `README.md`.


# ruby-project-template
[![Build Status Master](https://travis-ci.org/chef/ruby-project-template.svg?branch=master)](https://travis-ci.org/chef/ruby-project-template)
[![Build Status Master](https://ci.appveyor.com/api/projects/status/github/chef/ruby-project-template?branch=master&svg=true&passingText=master%20-%20Ok&pendingText=master%20-%20Pending&failingText=master%20-%20Failing)](https://ci.appveyor.com/project/Chef/ruby-project-template/branch/master)


# DESCRIPTION:

ruby-project-template does stuff. TODO describe

Chef distributes ruby-project-template as a RubyGem. This README is for developers who
want to modify the <Ruby Project Template> source code. For users who want to write plugins
for <Ruby Project Template>, see the docs:

* General documentation: http://docs.chef.io/ruby_project_template.html
* Custom plugin documentation: http://docs.chef.io/ruby_project_template_custom.html

# DEVELOPMENT:

Before working on the code, if you plan to contribute your changes, you
should read the contributing guidelines:

* https://github.com/chef/ruby-project-template/blob/master/CONTRIBUTING.md

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

Ohai has some Rake tasks for doing various things.

    rake -T
    rake clobber_package  # Remove package products
    rake gem              # Build the gem file ruby-project-template-$VERSION.gem
    rake install          # install the gem locally
    rake make_spec        # create a gemspec file
    rake package          # Build all the packages
    rake repackage        # Force a rebuild of the package files
    rake spec             # Run specs

    ($VERSION is the current version, from the GemSpec in Rakefile)

# RELEASING

To release a new version:

1. Ensure the CHANGELOG is up to date.
2. Ship DOC_CHANGES (put the docs wherever they belong) and empty it out.
3. Update the version number in `version.rb`
4. `bundle exec rake release` (this will create a git tag for the version, push git commits and tags, and build and push the `.gem` file to [rubygems.org](https://rubygems.org)

# LINKS:

Source:

* http://github.com/chef/ruby-project-template/tree/master

Issues:

* https://github.com/chef/ruby-project-template/issues

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
