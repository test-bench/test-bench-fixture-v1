module TestBench
  module Fixture
    module Controls
      module Result
        def self.example
          Pass.example
        end

        module Pass
          def self.example
            true
          end
        end

        module Failure
          def self.example
            false
          end
        end
      end
    end
  end
end
