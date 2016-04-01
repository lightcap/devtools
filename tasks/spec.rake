begin
  require 'rspec/core/rake_task'

  # Remove existing same-named tasks
  %w[spec spec:unit spec:integration].each do |task|
    klass = Rake::Task
    klass[task].clear if klass.task_defined?(task)
  end

  desc 'Run all specs'
  RSpec::Core::RakeTask.new(:spec) do |task|
    task.pattern = 'spec/{unit,features,integration}/**/*_spec.rb'
  end

  namespace :spec do
    desc 'Run unit specs'
    RSpec::Core::RakeTask.new(:unit) do |task|
      task.pattern = 'spec/unit/**/*_spec.rb'
    end

    desc 'Run integration specs'
    RSpec::Core::RakeTask.new(:integration) do |task|
      task.pattern = 'spec/integration/**/*_spec.rb'
    end

    desc 'Run feature specs'
    RSpec::Core::RakeTask.new(:features) do |task|
      task.pattern = 'spec/features/**/*_spec.rb'
    end
  end
rescue LoadError
  %w[spec spec:unit spec:integration spec:features].each do |name|
    task name do
      $stderr.puts "In order to run #{name}, do: gem install rspec"
    end
  end
end

task test: :spec
