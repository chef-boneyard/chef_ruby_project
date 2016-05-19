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

module ChefRubyProject
  #
  # Represents the top level of the project.
  #
  class Project
    #
    # Create a new Project
    #
    # @param root_path The root of the repository
    # @param version_path The path to the version file. Defaults to VERSION.
    #   Relative to root_path.
    # @param gemspec_path The gemspec we can read gem information like
    #   name and require_paths from. Defaults to the gemspec in the top level
    #   directory (if there are more than one, it picks the first one in alphabetical
    #   order, on the assumption that all of them represent the same gem).
    #   Relative to root_path.
    #
    def initialize(root_path,
                   gemspec_path: default_gemspec_path(root_path),
                   version_path: "VERSION")
      @root_path = root_path
      @version_path = File.expand_path(version_path, root_path)
      @gemspec_path = File.expand_path(gemspec_path, root_path)
    end

    #
    # The top level root directory (the one containing the Rakefile)
    #
    attr_reader :root_path

    #
    # The gemspec we will read gem information like name and require_paths from.
    #
    # @return [String] The full path to the version file
    #
    attr_reader :gemspec_path

    #
    # The version file.
    #
    attr_reader :version_path

    #
    # The name of the gem (read from gemspec_path)
    #
    def gem_name
      gemspec.name
    end

    #
    # The parsed gemspec.
    #
    # @param [Gem::Specification] The parsed gemspec.
    #
    def gemspec
      @gemspec ||= Gem::Specification.load(gemspec_path)
    end

    #
    # Read the current version from the version file
    #
    def read_version
      IO.read(version_path).strip
    end

    private

    #
    # The default gemspec (the first one alphabetically).
    #
    def default_gemspec_path(root_path)
      result = Dir.entries(root_path).sort.select { |f| File.extname(f) == ".gemspec" }.first
      raise "No gemspecs in #{root_path}" unless result
      result
    end
  end
end
