require_relative '../../automated_init'

context "Session Substitute" do
  context "Test Predicates" do
    context "One Test Passed Predicate" do
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

        context "Other Context" do
          context "Pass" do
            test "Some test" do
              assert(true)
            end
          end
        end
      end

      context "Exactly One Matching Test Passed" do
        one_test_passed = substitute.one_test_passed?("Some Context", "Some test")

        test "One test passed" do
          assert(one_test_passed)
        end
      end

      context "Multiple Passing Tests Match" do
        test "Is an error" do
          assert_raises(Fixture::Output::Substitute::MatchError) do
            substitute.one_test_passed?("Pass", "Some test")
          end
        end
      end

      context "No Matching Tests Passed" do
        one_test_passed = substitute.one_test_passed?("Failure", "Some test")

        test "One test did not pass" do
          refute(one_test_passed)
        end
      end
    end
  end
end
