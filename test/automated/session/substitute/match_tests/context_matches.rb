require_relative '../../../automated_init'

context "Session" do
  context "Substitute" do
    context "Match Tests" do
      context "Context Matches" do
        substitute = Fixture::Session::Substitute.build

        substitute.instance_exec do
          (1..3).each do |index|
            context "Example Context ##{index}" do
              test "Some test" do
                #
              end

              test "Other test" do
                #
              end
            end
          end
        end

        tests = substitute.match_tests("Example Context #2")

        test do
          assert(tests == [
            "Example Context #2\tSome test",
            "Example Context #2\tOther test"
          ])
        end
      end
    end
  end
end
