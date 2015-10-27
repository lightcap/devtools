# Stdlib infrastructure
require 'pathname'
require 'rake'
require 'timeout'
require 'yaml'
require 'fileutils'

# Non stdlib infrastructure
require 'procto'
require 'anima'
require 'concord'
require 'adamantium'

# Wrapped tools
require 'flay'
require 'rspec'
require 'rspec/its'

# Main devtools namespace population
module Devtools

  ROOT                    = Pathname.new(__FILE__).parent.parent.freeze
  PROJECT_ROOT            = Pathname.pwd.freeze
  SHARED_PATH             = ROOT.join('shared').freeze
  SHARED_SPEC_PATH        = SHARED_PATH.join('spec').freeze
  DEFAULT_CONFIG_PATH     = ROOT.join('default/config').freeze
  RAKE_FILES_GLOB         = ROOT.join('tasks/**/*.rake').to_s.freeze
  LIB_DIRECTORY_NAME      = 'lib'.freeze
  SPEC_DIRECTORY_NAME     = 'spec'.freeze
  RAKE_FILE_NAME          = 'Rakefile'.freeze
  SHARED_SPEC_PATTERN     = '{shared,support}/**/*.rb'.freeze
  UNIT_TEST_PATH_REGEXP   = %r{\bspec/unit/}.freeze
  DEFAULT_CONFIG_DIR_NAME = 'config'.freeze

  private_constant(*constants(false))

  # React to metric violation
  #
  # @param [String] msg
  #
  # @return [undefined]
  #
  # @api private
  def self.notify_metric_violation(msg)
    abort(msg)
  end

  # Initialize project and load tasks
  #
  # Should *only* be called from your $application_root/Rakefile
  #
  # @return [self]
  #
  # @api public
  def self.init_rake_tasks
    Project::Initializer::Rake.call
    self
  end

  # Return devtools root path
  #
  # @return [Pathname]
  #
  # @api private
  def self.root
    ROOT
  end

  # Return project
  #
  # @return [Project]
  #
  # @api private
  def self.project
    PROJECT
  end

  # Require shared examples
  #
  # @param [Pathname] dir
  #   the directory containing the files to require
  #
  # @param [String] pattern
  #   the file pattern to match inside directory
  #
  # @return [self]
  #
  # @api private
  def self.require_files(dir, pattern)
    Dir[dir.join(pattern)].each { |file| require file }
    self
  end

  # Detect ci
  #
  # @return [Boolean]
  #
  # @api private
  #
  def self.ci?
    ENV.key?('CI')
  end

  # Detect circle ci
  #
  # @return [Boolean]
  #
  # @api private
  #
  def self.circle_ci?
    ENV.key?('CIRCLECI')
  end

  # Detect travis ci
  #
  # @return [Boolean]
  #
  # @api private
  #
  def self.travis?
    ENV.key?('TRAVIS')
  end

end # module Devtools

# Devtools implementation
require 'devtools/config'
require 'devtools/project'
require 'devtools/project/initializer'
require 'devtools/project/initializer/rake'
require 'devtools/project/initializer/rspec'
require 'devtools/flay'
require 'devtools/rake/flay'

# Devtools self initialization
module Devtools
  # The project devtools is active for
  PROJECT = Project.new(PROJECT_ROOT)
end
