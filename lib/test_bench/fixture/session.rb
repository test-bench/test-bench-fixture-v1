module TestBench
  module Fixture
    class Session
      Error = Class.new(RuntimeError)
      AbortContext = Class.new(RuntimeError)

      def assertion_counter
        @assertion_counter ||= 0
      end
      attr_writer :assertion_counter

      def failure_counter
        @failure_counter ||= 0
      end
      attr_writer :failure_counter

      def skip_counter
        @skip_counter ||= 0
      end
      attr_writer :skip_counter

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
        @error_policy ||= ErrorPolicy::RescueAssert.new
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

      def assert(value, caller_location: nil)
        caller_location ||= caller[0]

        result = value ? true : false

        self.assertion_counter += 1

        output.assert(result, caller_location)

        unless result
          assertion_failure = AssertionFailure.build(caller_location)
          raise assertion_failure
        end

        result
      end

      def load(path)
        output.enter_file(path)

        result = false

        Kernel.load(path)

        result = true

      ensure

        output.exit_file(path, result)
      end

      def test(title=nil, &block)
        if block.nil?
          record_skip
          output.skip_test(title)
          return
        end

        output.start_test(title)

        previous_failure_counter = self.failure_counter
        previous_assertion_counter = self.assertion_counter

        action = ->{
          block.()

          if failure_counter == previous_failure_counter
            if assertion_counter == previous_assertion_counter
              raise Error, "Test did not perform an assertion"
            end
          end
        }

        evaluate(action) do |result|
          output.finish_test(title, result)
        end
      end

      def context(title=nil, &block)
        if block.nil?
          record_skip
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

        result = evaluate(action) do |result|
          output.finish_fixture(fixture, result)
        end

        result
      end

      def evaluate(action, &block)
        previous_failure_counter = self.failure_counter

        begin
          action.()

        rescue AbortContext

        rescue => error
          record_failure

          output.error(error)

          error_policy.(error)
          error = nil

        ensure
          result = failure_counter == previous_failure_counter

          block.(result, error) unless block.nil?
        end

        result
      end

      def record_failure
        self.failure_counter += 1
      end
      alias_method :fail!, :record_failure

      def failed?
        failure_counter.nonzero? ? true : false
      end

      def record_skip
        self.skip_counter += 1
      end

      def skipped?
        skip_counter.nonzero? ? true : false
      end
    end
  end
end
