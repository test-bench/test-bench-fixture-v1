require_relative '../../../automated_init'

context "Session" do
  context "Substitute" do
    context "Match Tests" do
      context "Skipped Test Matches" do
        substitute = Fixture::Session::Substitute.build

        substitute.instance_exec do
          context "Some Context" do
            test "Some test"
          end

          context "Other Context" do
            test "Some test" do
              #
            end
          end
        end

        tests = substitute.match_tests("Some test")

        test "Not returned" do
          assert(tests == ["Other Context\tSome test"])
        end
      end
    end
  end
end
