# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'yard'

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

YARD::Rake::YardocTask.new do |t|
 t.files   = ['lib/**/*.rb']
 # t.stats_options = ['--list-undoc']         # optional
end

task default: %i[spec rubocop]
