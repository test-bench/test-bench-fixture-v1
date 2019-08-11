module TestBench
  module Fixture
    class Session
      def error_counter
        @error_counter ||= 0
      end
      attr_writer :error_counter

      def fail!
        self.error_counter += 1
      end

      def failed?
        error_counter.nonzero?
      end
    end
  end
end
