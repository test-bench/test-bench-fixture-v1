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

      def depth
        @depth ||= 0
      end
      attr_writer :depth

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
    end
  end
end
