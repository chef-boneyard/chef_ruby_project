#
# Author:: John Keiser (<jkeiser@chef.io>)
# Copyright:: Copyright (c) 2016 Chef Software, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require_relative "chef_ruby_project/version"

module ChefRubyProject
  extend self
  attr_reader :project
  def define_rake_tasks(rakefile: Rake.application.rakefile, **project_options, &block)
    require_relative "chef_ruby_project/project"
    @project = Project.new(File.dirname(File.expand_path(rakefile, Dir.pwd)), **project_options)
    require_relative "chef_ruby_project/rake_tasks"
    RakeTasks.class_eval(&block)
  end
end
