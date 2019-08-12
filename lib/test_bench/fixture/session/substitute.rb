module TestBench
  module Fixture
    class Session
      module Substitute
        def self.build
          Session.new
        end

        class Session < Session
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
