require_relative '../../automated_init'

context "Session Substitute" do
  context "Test Predicates" do
    context "Any Test Predicate" do
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
        any_test = substitute.any_test?("Some Context", "Some test")

        test do
          assert(any_test == true)
        end
      end

      context "Multiple Tests Match" do
        any_test = substitute.any_test?("Some test")

        test do
          assert(any_test == true)
        end
      end

      context "No Tests Match" do
        any_test = substitute.any_test?("Other test")

        test do
          assert(any_test == false)
        end
      end
    end
  end
end
