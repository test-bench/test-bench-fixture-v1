module TestBench
  module Fixture
    class Session
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
