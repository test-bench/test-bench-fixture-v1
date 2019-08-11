module TestBench
  module Fixture
    module Output
      module Substitute
        def self.build
          Output.new
        end

        class Output < Capture
        end
      end
    end
  end
end
