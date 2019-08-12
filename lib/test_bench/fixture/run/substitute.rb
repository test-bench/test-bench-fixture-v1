module TestBench
  module Fixture
    class Run
      module Substitute
        def self.build
          Run.new
        end

        class Run < Run
          def commented?(text)
            output.recorded?(:comment) do |t|
              t == text
            end
          end
        end
      end
    end
  end
end
