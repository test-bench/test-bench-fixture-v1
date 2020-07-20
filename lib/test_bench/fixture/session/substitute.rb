module TestBench
  module Fixture
    class Session
      module Substitute
        def self.build
          Session.new
        end

        class Session < Session
          def any_test_passed?(*contexts, title)
            any_test?(*contexts, title) do |_, result|
              result == true
            end
          end

          def any_test_failed?(*contexts, title)
            any_test?(*contexts, title) do |_, result|
              result == false
            end
          end

          def any_test?(*contexts, title, &block)
            test_scope = test_scope(*contexts, title)

            test_scope.finish_test_recorded?(&block)
          end

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

          def load(path)
            output.enter_file(path)

            inert_action = proc { }
            result = evaluate(inert_action)

            output.exit_file(path, result)

            result
          end

          def loaded?(path=nil)
            output.enter_file_recorded? do |p|
              path.nil? || p == path
            end
          end

          def test_scope(*contexts, title)
            context_scope = output.scope(*contexts)

            titled_test_scope = context_scope.scope do |signal, t|
              signal == :finish_test && t == title
            end

            untitled_test_scope = context_scope.scope(title) do |signal, t|
              signal == :finish_test && t.nil?
            end

            titled_test_scope + untitled_test_scope
          end
        end
      end
    end
  end
end
