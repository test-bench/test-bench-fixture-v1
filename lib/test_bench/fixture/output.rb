module TestBench
  module Fixture
    module Output
      def assert(result, caller_location)
      end

      def enter_assert_block(caller_location)
      end

      def exit_assert_block(result, caller_location)
      end

      def comment(text)
      end

      def error(error)
      end

      def start_test(title)
      end

      def finish_test(title, result)
      end

      def skip_test(title)
      end

      def enter_context(title)
      end

      def exit_context(title, result)
      end

      def skip_context(title)
      end
    end
  end
end
