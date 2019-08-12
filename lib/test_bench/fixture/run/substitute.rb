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

          def asserted?(result=nil, caller_location: nil)
            output.recorded?(:assert) do |r, cl|
              (result.nil? || r == result) &&
              (caller_location.nil? || cl == caller_location)
            end
          end

          def test?(title)
            output.recorded?(:finish_test) do |t|
              t == title
            end
          end

          def context?(title)
            output.recorded?(:exit_context) do |t|
              t == title
            end
          end
        end
      end
    end
  end
end
