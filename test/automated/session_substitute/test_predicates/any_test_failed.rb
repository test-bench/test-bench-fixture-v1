require_relative '../../automated_init'

context "Session Substitute" do
  context "Test Predicates" do
    context "Any Test Failed Predicate" do
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

      context "Exactly One Matching Test Failed" do
        any_test_failed = substitute.any_test_failed?("Failure", "Some test")

        test "Any test failed" do
          assert(any_test_failed)
        end
      end

      context "More Than One Matching Test Failed" do
        any_test_failed = substitute.any_test_failed?("Some Context", "Some test")

        test "Any test failed" do
          assert(any_test_failed)
        end
      end

      context "No Matching Tests Failed" do
        any_test_failed = substitute.any_test_failed?("Pass", "Some test")

        test "Any test did not fail" do
          refute(any_test_failed)
        end
      end
    end
  end
end
