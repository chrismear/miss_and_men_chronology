# frozen_string_literal: true

require 'rake'
require 'rspec/core/rake_task'

task default: :spec

RSpec::Core::RakeTask.new(:spec) do |task|
  task.pattern = 'spec/**/*_spec.rb'
end
