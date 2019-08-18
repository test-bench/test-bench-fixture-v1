module TestBench
  module Fixture
    class Session
      module Substitute
        def self.build
          Session.new
        end

        class Session < Session
          Error = Class.new(RuntimeError)

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

          def fixture?(fixture)
            output.recorded?(:finish_fixture) do |f|
              f == fixture
            end
          end

          def test_passed?(*titles)
            !pass(*titles).nil?
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

          def one_failure(*titles)
            failures = failures(*titles)

            if failures.count > 1
              raise Error, "Multiple failing tests match (Titles: #{titles.inspect})"
            end

            failures.first
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
