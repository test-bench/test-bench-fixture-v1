module TestBench
  module Fixture
    class Run
      def assertion_counter
        @assertion_counter ||= 0
      end
      attr_writer :assertion_counter

      def error_counter
        @error_counter ||= 0
      end
      attr_writer :error_counter

      def error_policy
        @error_policy ||= ErrorPolicy::Build.(:rescue_assert)
      end
      attr_writer :error_policy

      def output
        @output ||= Output::Substitute.build
      end
      attr_writer :output

      def failed?
        error_counter.nonzero?
      end

      def comment(text)
        output.comment(text)
      end

      def error(error)
        self.error_counter += 1

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

      def evaluate(action, &block)
        previous_error_counter = self.error_counter

        begin
          action.()

        rescue => error
          error(error)

        ensure
          result = error_counter == previous_error_counter

          block.(result) unless block.nil?
        end

        result
      end
    end
  end
end
