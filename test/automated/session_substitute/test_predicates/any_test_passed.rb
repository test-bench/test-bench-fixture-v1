require_relative '../../automated_init'

context "Session Substitute" do
  context "Test Predicates" do
    context "Any Test Passed" do
      substitute = Fixture::Session::Substitute.build

      substitute.instance_exec do
        context "Some Context" do
          context "Pass" do
            test "Some test" do
              assert(true)
            end
          end

          context "Failure" do
            test "Some test" do
              assert(false)
            end
          end
        end
      end

      context "Exactly One Matching Test Passed" do
        any_test_passed = substitute.any_test_passed?("Pass", "Some test")

        test "Any test passed" do
          assert(any_test_passed)
        end
      end

      context "More Than One Matching Test Passed" do
        any_test_passed = substitute.any_test_passed?("Some Context", "Some test")

        test "Any test passed" do
          assert(any_test_passed)
        end
      end

      context "No Matching Tests Passed" do
        any_test_passed = substitute.any_test_passed?("Failure", "Some test")

        test "Any test did not pass" do
          refute(any_test_passed)
        end
      end
    end
  end
end
