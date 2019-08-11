module TestBench
  module Fixture
    class AssertionFailure < RuntimeError
      def self.build(caller_location=nil)
        caller_location ||= caller_locations.first

        backtrace = [caller_location.to_s]

        instance = new(message)
        instance.set_backtrace(backtrace)
        instance
      end

      def self.message
        'Assertion failed'
      end
    end
  end
end
