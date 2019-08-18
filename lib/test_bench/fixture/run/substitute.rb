module TestBench
  module Fixture
    class Run
      module Substitute
        def self.build
          Run.new
        end

        class Run < Run
          Error = Class.new(RuntimeError)

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

          def one_pass(*titles)
            passes = passes(*titles)

            if passes.count > 1
              raise Error, "Multiple passing tests match (Titles: #{titles.inspect})"
            end

            passes.first
          end

          def pass(*titles)
            passes(*titles).first
          end

          def passes(*titles)
            match_tests(*titles, result: true)
          end

          def failure(*titles)
            failures(*titles).first
          end

          def failures(*titles)
            match_tests(*titles, result: false)
          end

          def match_tests(*titles, result: nil)
            MatchTests.(self, *titles, result: result)
          end
        end
      end
    end
  end
end
