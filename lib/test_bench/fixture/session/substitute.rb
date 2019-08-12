module TestBench
  module Fixture
    class Session
      module Substitute
        def self.build
          Session.new
        end

        class Session < Session
          attr_accessor :load_failure

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

          def load_failure!
            self.load_failure = true
          end

          def load(path)
            result = load_failure ? false : true

            output.enter_file(path)

            output.exit_file(path, result)

            result
          end

          def loaded?(path)
            output.recorded?(:exit_file) do |p|
              p == path
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
