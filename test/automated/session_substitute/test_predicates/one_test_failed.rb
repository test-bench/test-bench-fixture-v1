require_relative '../../automated_init'

context "Session Substitute" do
  context "Test Predicates" do
    context "One Test Failed" do
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
          context "Failure" do
            test "Some test" do
              assert(false)
            end
          end
        end
      end

      context "Exactly One Matching Test Failed" do
        one_test_failed = substitute.one_test_failed?("Some Context", "Some test")

        test "One test failed" do
          assert(one_test_failed)
        end
      end

      context "Multiple Failing Tests Match" do
        test "Is an error" do
          assert_raises(Fixture::Output::Substitute::MatchError) do
            substitute.one_test_failed?("Failure", "Some test")
          end
        end
      end

      context "No Matching Tests Failed" do
        one_test_failed = substitute.one_test_failed?("Pass", "Some test")

        test "One test did not fail" do
          refute(one_test_failed)
        end
      end
    end
  end
end
