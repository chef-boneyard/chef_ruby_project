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

require "rake"

module ChefRubyProject
  module RakeTasks
    include Rake::DSL
    extend self

    #
    # The gem tasks:
    # - build
    # - install
    # - install:local
    # - release
    # - release:guard_clean
    # - release:source_control_push
    # - release:rubygem_push
    #
    # @param build_task_name [String] Name of build task. Must be "build"
    # @param install_task_name [String] Name of install task. Must be "install"
    # @param release_task_name [String] Name of release task. Must be "release"
    #
    # @example
    #    gem_tasks "build", "install", "release"
    #
    def gem_tasks(build_task_name, install_task_name, release_task_name)
      raise "gem build task must be named build" unless build_task_name.to_s == "build"
      raise "gem install task must be named install" unless install_task_name.to_s == "install"
      raise "gem release task must be named release" unless release_task_name.to_s == "release"

      gemspec_name = File.basename(ChefRubyProject.project.gemspec_path)
      if gemspec_name =~ /(.*)\.gemspec$/
        gemspec_name = $1
      else
        raise "Gemspec must end in .gemspec for ruby gem tasks to work: #{gemspec_path} is invalid."
      end

      begin
        require "bundler/gem_helper"
      rescue LoadError
        task("build") { |t| raise "Could not load bundler/gem_helper! Include bundler to use rake #{t.name}" }
        task("install") { |t| raise "Could not load bundler/gem_helper! Include bundler to use rake #{t.name}" }
        task("release") { |t| raise "Could not load bundler/gem_helper! Include bundler to use rake #{t.name}" }
        return
      end

      Bundler::GemHelper.install_tasks(name: gemspec_name)
    end

    def chefstyle_task(*task_args, &block)
      task = task_with_require(task_args, ["chefstyle", "rubocop/rake_task"]) do
        RuboCop::RakeTask.new(*task_args) do |task, args|
          task.options += ["--display-cop-names", "--no-color"]
          instance_exec(task, args, &block) if block
        end
      end
    end

    def changelog_task(*task_args, &block)
      task_with_require(task_args, "github_changelog_generator/task") do
        GitHubChangelogGenerator::RakeTask.new(*task_args) do |config, args|
  #        config.user = "chef"
  #        config.project = "chef-dk"
          config.future_release = ChefRubyProject.project.read_version.to_s
          config.enhancement_labels = "enhancement,Enhancement,New Feature,Feature".split(",")
          config.bug_labels = "bug,Bug,Improvement,Upstream Bug".split(",")
          config.exclude_labels = "duplicate,question,invalid,wontfix,no_changelog,Exclude From Changelog,Question,Upstream Bug,Discussion".split(",")
          instance_exec(config, args, &block) if block
        end
      end
    end

    def rspec_task(*task_args, &block)
      task_with_require(task_args, "rspec/core/rake_task") do
        RSpec::Core::RakeTask.new(*task_args, &block)
      end
    end

    def yard_task(*task_args, &block)
      task_with_require(task_args, "yard") do
        YARD::Rake::YardocTask.new(*task_args, &block)
      end
    end

    #
    # Require the given files, but if they fail, just have the task tell the
    # user to install that gem. If they succeed, the block is run so you can
    # define the task yourself.
    #
    # @param task_args [Array] The arguments to the task creation (e.g. `:task_name`)
    # @param require_files [Array] The files to require. The gems they come in are inferred
    #   from the filenames (e.g. `"github_changelog_generator/task" => "github_changelog_generator"`)
    #
    def task_with_require(task_args, require_files, &block)
      Array(require_files).each do |require_file, gem_name|
        begin
          require require_file
        rescue LoadError
          # Get the top level filename, use that as the gem name
          gem_name ||= Pathname(require_file).each_filename.first
          return task(*task_args) do |t, *args|
            raise "#{require_file} not available. Please install #{gem_name} to enable \"rake #{t.name}\""
          end
        end
      end

      # We'll only get here if we were able to require all files.
      yield
    end
  end
end
