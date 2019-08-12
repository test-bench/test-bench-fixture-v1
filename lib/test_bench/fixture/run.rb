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

      def assert_block(caller_location: nil, &block)
        caller_location ||= caller_locations.first

        previous_assertion_counter = self.assertion_counter

        output.enter_assert_block(caller_location)

        evaluate(block) do |result, error|
          if result && assertion_counter == previous_assertion_counter
            result = false
          end

          output.exit_assert_block(caller_location, result)

          if error.nil?
            assert(result, caller_location: caller_location)
          end
        end
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

      def evaluate(action, &block)
        previous_error_counter = self.error_counter

        begin
          action.()

        rescue => error
          error(error)

        ensure
          result = error_counter == previous_error_counter

          block.(result, $!) unless block.nil?
        end

        result
      end
    end
  end
end
