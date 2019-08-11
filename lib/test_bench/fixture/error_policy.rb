module TestBench
  module Fixture
    module ErrorPolicy
      class Abort
        def call(error)
          abort "TestBench is aborting (#{self.class})"
        end
      end
    end
  end
end
