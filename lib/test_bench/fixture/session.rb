module TestBench
  module Fixture
    class Session
      Error = Class.new(RuntimeError)
      Abort = Class.new(RuntimeError)

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

        source = File.read(path)
        TOPLEVEL_BINDING.eval(source, path)

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

      def evaluate(action, &block)
        previous_failure_counter = self.failure_counter

        begin
          action.()

        rescue Abort

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
