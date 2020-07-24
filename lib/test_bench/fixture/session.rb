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

      def fail!
        self.assertion_counter += 1
        self.error_counter += 1
      end

      def failed?
        error_counter.nonzero? ? true : false
      end
    end
  end
end
