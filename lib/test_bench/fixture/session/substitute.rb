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

          def asserted?(result=nil, caller_location: nil)
            output.recorded?(:assert) do |r, cl|
              (result.nil? || r == result) &&
              (caller_location.nil? || cl == caller_location)
            end
          end
        end
      end
    end
  end
end
