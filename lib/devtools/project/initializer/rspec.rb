module Devtools
  class Project
    class Initializer

      # Requires all shared specs in a project's spec_helper
      # Also installs a configurable unit test timeout
      class Rspec < self
        include Concord.new(:project)

        # Call initializer for project
        #
        # @param [Project] project
        #
        # @return [self]
        #
        # @api private
        def self.call(project)
          new(project).__send__(:call)
          self
        end

      private

        # Setup RSpec for project
        #
        # @return [self]
        #
        # @api private
        def call
          require_shared_spec_files
          enable_unit_test_timeout
        end

        # Timeout unit tests that take longer than configured amount of time
        #
        # @param [Numeric] timeout
        #
        # @return [undefined]
        #
        # @raise [Timeout::Error]
        #   raised when the times are outside the timeout
        #
        # @api private
        #
        def enable_unit_test_timeout
          timeout = project.unit_test_timeout
          RSpec.configuration.around(file_path: UNIT_TEST_PATH_REGEXP) do |example|
            Timeout.timeout(timeout, &example)
          end
        end

        # Trigger the require of shared spec files
        #
        # @return [undefined]
        #
        # @api private
        #
        def require_shared_spec_files
          Devtools.require_files(SHARED_SPEC_PATH,  SHARED_SPEC_PATTERN)
          Devtools.require_files(project.spec_root, SHARED_SPEC_PATTERN)
        end

      end # class Rspec
    end # class Initializer
  end # class Project
end # module Devtools
