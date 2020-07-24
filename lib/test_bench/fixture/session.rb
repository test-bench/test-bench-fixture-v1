module TestBench
  module Fixture
    class Session
      def failure_counter
        @failure_counter ||= 0
      end
      attr_writer :failure_counter

      def skip_counter
        @skip_counter ||= 0
      end
      attr_writer :skip_counter

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
