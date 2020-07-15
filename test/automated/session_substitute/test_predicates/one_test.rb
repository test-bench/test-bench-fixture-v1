require_relative '../../automated_init'

context "Session Substitute" do
  context "Test Predicates" do
    context "One Test Predicate" do
      substitute = Fixture::Session::Substitute.build

      substitute.instance_exec do
        context "Some Context" do
          test "Some test" do
            assert(true)
          end
        end

        context "Other Context" do
          test "Some test" do
            assert(true)
          end
        end
      end

      context "One Test Matches" do
        one_test = substitute.one_test?("Some Context", "Some test")

        test do
          assert(one_test == true)
        end
      end

      context "Multiple Tests Match" do
        test "Is an error" do
          assert_raises(Fixture::Output::Substitute::MatchError) do
            substitute.one_test?("Some test")
          end
        end
      end

      context "No Tests Match" do
        one_test = substitute.one_test?("Other test")

        test do
          assert(one_test == false)
        end
      end
    end
  end
end
