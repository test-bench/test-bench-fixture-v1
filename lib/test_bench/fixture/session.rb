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

      def assert_block(caller_location: nil, &block)
        caller_location ||= caller_locations.first

        previous_error_counter = self.error_counter
        previous_assertion_counter = self.assertion_counter

        output.enter_assert_block(caller_location)

        begin
          block.()

        ensure
          if self.error_counter > previous_error_counter
            result = false
          elsif self.assertion_counter == previous_assertion_counter
            result = false
          else
            result = true
          end

          output.exit_assert_block(caller_location, result)

          current_exception = $!
          if current_exception.nil? || current_exception.instance_of?(AssertionFailure)
            assert(result, caller_location: caller_location)
          end
        end
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

        evaluate(block) do |result|
          output.finish_test(title, result)
        end
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
        self.error_counter += 1
      end

      def failed?
        error_counter.nonzero? ? true : false
      end
    end
  end
end
