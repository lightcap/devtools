module Devtools

  # The project devtools supports
  class Project

    # The reek configuration
    #
    # @return [Config::Reek]
    #
    # @api private
    attr_reader :reek

    # The rubocop configuration
    #
    # @return [Config::Rubocop]
    #
    # @api private
    attr_reader :rubocop

    # The flog configuration
    #
    # @return [Config::Flog]
    #
    # @api private
    attr_reader :flog

    # The yardstick configuration
    #
    # @return [Config::Yardstick]
    #
    # @api private
    attr_reader :yardstick

    # The flay configuration
    #
    # @return [Config::Flay]
    #
    # @api private
    attr_reader :flay

    # The mutant configuration
    #
    # @return [Config::Mutant]
    #
    # @api private
    attr_reader :mutant

    # The devtools configuration
    #
    # @return [Config::Devtools]
    #
    # @api private
    attr_reader :devtools

    # Return project root
    #
    # @return [Pathname]
    #
    # @api private
    #
    attr_reader :root

    # The default config path
    #
    # @return [Pathname]
    #
    # @api private
    attr_reader :default_config_path

    # The lib directory
    #
    # @return [Pathname]
    #
    # @api private
    attr_reader :lib_dir

    # The Ruby file pattern
    #
    # @return [Pathname]
    #
    # @api private
    attr_reader :file_pattern

    # The spec root
    #
    # @return [Pathname]
    #
    # @api private
    attr_reader :spec_root

    # Return config directory
    #
    # @return [Pathname]
    #
    # @api private
    attr_reader :config_dir

    # The unit test timeout
    #
    # @return [Numeric]
    #
    # @api private
    attr_reader :unit_test_timeout

    # Initialize object
    #
    # @param [Pathname] root
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(root)
      @root = root

      initialize_environment
      initialize_configs

      @unit_test_timeout = @devtools.unit_test_timeout
    end

    # Init rspec
    #
    # @return [self]
    #
    # @api private
    def init_rspec
      Initializer::Rspec.call(self)
      self
    end

  private

    # Initialize environment
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize_environment
      @default_config_path = @root.join(DEFAULT_CONFIG_DIR_NAME).freeze
      @lib_dir             = @root.join(LIB_DIRECTORY_NAME).freeze
      @spec_root           = @root.join(SPEC_DIRECTORY_NAME).freeze
      @file_pattern        = @lib_dir.join(RB_FILE_PATTERN).freeze
      @config_dir          = @default_config_path
    end

    # Initialize configs
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize_configs
      @reek      = Config::Reek.new(self)
      @rubocop   = Config::Rubocop.new(self)
      @flog      = Config::Flog.new(self)
      @yardstick = Config::Yardstick.new(self)
      @flay      = Config::Flay.new(self)
      @mutant    = Config::Mutant.new(self)
      @devtools  = Config::Devtools.new(self)
    end

  end # class Project
end # module Devtools
