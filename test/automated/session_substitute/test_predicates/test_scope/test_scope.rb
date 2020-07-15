require_relative '../../../automated_init'

context "Session Substitute" do
  context "Test Predicates" do
    context "Test Scope" do
      substitute = Fixture::Session::Substitute.build

      substitute.instance_exec do
        context "Some Context" do
          test "Some test" do
            assert(true)
          end

          test "Other test" do
            assert(false)
          end
        end

        context "Other Context" do
          test "Some test" do
            assert(false)
          end
        end
      end

      test_scope = substitute.test_scope("Some test")

      context "First Test [Some Context > Some test]" do
        in_scope = test_scope.finish_test_recorded_once? do |title, *, context|
          title == "Some test" && context == ["Some Context"]
        end

        test "In scope" do
          assert(in_scope)
        end
      end

      context "Second Test [Some Context > Other test]" do
        in_scope = test_scope.finish_test_recorded_once? do |title, *, context|
          title == "Other test"
        end

        test "Not in scope" do
          refute(in_scope)
        end
      end

      context "Third Test [Some test]" do
        in_scope = test_scope.finish_test_recorded_once? do |title, *, context|
          title == "Some test" && context == ["Other Context"]
        end

        test "In scope" do
          assert(in_scope)
        end
      end
    end
  end
end
