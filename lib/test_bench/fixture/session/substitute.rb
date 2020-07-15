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
        end
      end
    end
  end
end
