require_relative '../../../automated_init'

context "Session" do
  context "Substitute" do
    context "Match Tests" do
      context "No Context" do
        substitute = Fixture::Session::Substitute.build

        substitute.instance_exec do
          test "Some test" do
            #
          end

          test "Other test" do
            #
          end
        end

        tests = substitute.match_tests("Some test")

        test do
          assert(tests == ["Some test"])
        end
      end
    end
  end
end
