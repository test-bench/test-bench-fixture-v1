module TestBench
  module Fixture
    class Session
      module Substitute
        def self.build
          Session.new
        end

        class Session < Session
          def commented?(*contexts, text)
            output.comment_recorded?(*contexts) do |t|
              t == text
            end
          end

          def detail?(*contexts, text)
            output.detail_recorded?(*contexts) do |t|
              t == text
            end
          end

          def asserted?(*contexts, result: nil, caller_location: nil)
            output.assert_recorded?(*contexts) do |r, cl|
              result_match = result.nil? || r == result
              caller_location_match = caller_location.nil? || cl == caller_location

              result_match && caller_location_match
            end
          end
        end
      end
    end
  end
end
