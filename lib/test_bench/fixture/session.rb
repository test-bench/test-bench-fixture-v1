module TestBench
  module Fixture
    class Session
      Error = Class.new(RuntimeError)

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

      def fail!
        self.error_counter += 1
      end

      def failed?
        error_counter.nonzero? ? true : false
      end
    end
  end
end
