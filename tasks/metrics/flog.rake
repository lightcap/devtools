namespace :metrics do
  require 'flog'
  require 'flog_cli'

  # Original code by Marty Andrews:
  # http://blog.martyandrews.net/2009/05/enforcing-ruby-code-quality.html
  desc 'Measure code complexity'
  task :flog do
    Devtools::Rake::Flog.call(Devtools.project.flog)
  end
end
