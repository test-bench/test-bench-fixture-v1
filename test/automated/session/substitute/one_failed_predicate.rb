require_relative '../../automated_init'

context "Session" do
  context "Substitute" do
    context "One Failed Predicate" do
      substitute = Fixture::Session::Substitute.build

      substitute.instance_exec do
        context "Some Context" do
          test "Passing test" do
            #
          end

          test "Failing test" do
            assert(false)
          end
        end

        test "Failing test" do
          assert(false)
        end
      end

      context "One Test Matches" do
        test do
          assert(substitute.one_failed?("Some Context", "Failing test") == true)
        end
      end

      context "No Tests Match" do
        test do
          assert(substitute.one_failed?("Unknown test") == false)
        end
      end

      context "Multiple Tests Match" do
        test "Raises error" do
          assert_raises(Fixture::Session::Substitute::Session::Error) do
            substitute.one_failed?("Failing test")
          end
        end
      end
    end
  end
end
