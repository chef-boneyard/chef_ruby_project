require_relative "lib/chef_ruby_project"

ChefRubyProject.define_rake_tasks do
  multitask "default" => %w{spec style}
  gem_tasks "build", "install", "release"
  chefstyle_task "style"
  changelog_task "changelog"
  rspec_task "spec"
  yard_task "yard:html"
  task "yard" => "yard:html"
end
