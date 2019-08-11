module TestBench
  module Fixture
    module ErrorPolicy
      class Abort
        def call(error)
          abort "TestBench is aborting (#{self.class})"
        end
      end

      class Raise
        def call(error)
          raise error
        end
      end

      class Rescue
        def call(error)
        end
      end

      class RescueAssert
        def call(error)
          unless error.instance_of?(AssertionFailure)
            raise error
          end
        end
      end
    end
  end
end
