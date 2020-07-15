module TestBench
  module Fixture
    module Output
      def self.signals
        instance_methods(false)
      end

      def start
      end

      def finish(result)
      end

      def enter_file(path)
      end

      def exit_file(path, result)
      end

      def start_fixture(fixture)
      end

      def finish_fixture(fixture, result)
      end

      def assert(result, caller_location)
      end

      def comment(text)
      end

      def detail(text)
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
