require_relative '../../../automated_init'

context "Session" do
  context "Substitute" do
    context "Match Tests" do
      context "Optional Result Argument" do
        substitute = Fixture::Session::Substitute.build

        substitute.instance_exec do
          context "Some Context" do
            test "Some passing test" do
              #
            end

            test "Some failing test" do
              assert(false)
            end
          end
        end

        context "Given" do
          context "Passes" do
            tests = substitute.match_tests("Some Context", result: true)

            test do
              assert(tests == ["Some Context\tSome passing test"])
            end
          end

          context "Failures" do
            tests = substitute.match_tests("Some Context", result: false)

            test do
              assert(tests == ["Some Context\tSome failing test"])
            end
          end
        end

        context "Omitted" do
          tests = substitute.match_tests("Some Context")

          test "Returns all tests" do
            assert(tests == [
              "Some Context\tSome passing test",
              "Some Context\tSome failing test"
            ])
          end
        end
      end
    end
  end
end
