module TestBench
  module Fixture
    class Session
      Error = Class.new(RuntimeError)

      def assertion_counter
        @assertion_counter ||= 0
      end
      attr_writer :assertion_counter

      def error_counter
        @error_counter ||= 0
      end
      attr_writer :error_counter

      def skip
        @skip ||= false
      end
      attr_writer :skip
      alias_method :skip?, :skip

      def started
        instance_variable_defined?(:@started) ?
          @started :
          @started = false
      end
      attr_writer :started
      alias_method :started?, :started

      def finished
        instance_variable_defined?(:@finished) ?
          @finished :
          @finished = false
      end
      attr_writer :finished
      alias_method :finished?, :finished

      def error_policy
        @error_policy ||= ErrorPolicy::Build.(:rescue_assert)
      end
      attr_writer :error_policy

      def output
        @output ||= Output::Substitute.build
      end
      attr_writer :output

      def start
        if started
          raise Error, "Session has already been started"
        end

        self.started = true

        output.start
      end

      def finish
        if finished
          raise Error, "Session has already finished"
        end

        self.finished = true

        result = !failed?

        output.finish(result)

        result
      end

      def comment(text)
        output.comment(text)
      end

      def detail(text)
        output.detail(text)
      end

      def error(error)
        fail!

        output.error(error)

        error_policy.(error)
      end

      def assert(value, caller_location: nil)
        caller_location ||= caller_locations.first

        result = value ? true : false

        self.assertion_counter += 1

        output.assert(result, caller_location)

        unless result
          self.error_counter += 1

          assertion_failure = AssertionFailure.build(caller_location)
          raise assertion_failure
        end

        result
      end

      def load(path)
        output.enter_file(path)

        action = proc { Kernel.load(path) }

        result = evaluate(action)

        output.exit_file(path, result)

        result
      end

      def test(title=nil, &block)
        if block.nil?
          output.skip_test(title)
          return
        end

        output.start_test(title)

        previous_assertion_counter = self.assertion_counter

        action = proc {
          block.()

          unless assertion_counter > previous_assertion_counter
            raise Error, "Test did not perform an assertion"
          end
        }

        evaluate(action) do |result|
          output.finish_test(title, result)
        end
      end

      def context(title=nil, &block)
        if block.nil?
          output.skip_context(title)
          return
        end

        output.enter_context(title)

        evaluate(block) do |result|
          output.exit_context(title, result)
        end
      end

      def fixture(fixture, &block)
        if block.nil? && !fixture.respond_to?(:call)
          raise Error, "Block must be given when a fixture does not respond to #call"
        end

        actions = []

        if fixture.respond_to?(:call)
          actions << fixture
        end

        unless block.nil?
          actions << proc { block.(fixture) }
        end

        output.start_fixture(fixture)

        action = proc { actions.each(&:call) }
        result = evaluate(action)

        output.finish_fixture(fixture, result)

        result
      end

      def evaluate(action, &block)
        previous_error_counter = self.error_counter

        begin
          action.()

        rescue => error
          error(error)

        ensure
          current_exception = $!

          result = error_counter == previous_error_counter

          block.(result, current_exception) unless block.nil?
        end

        result
      end

      def fail!
        self.assertion_counter += 1
        self.error_counter += 1
      end

      def failed?
        error_counter.nonzero? ? true : false
      end

      def skip!
        self.skip = true
      end
    end
  end
end
