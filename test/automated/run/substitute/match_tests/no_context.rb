require_relative '../../../automated_init'

context "Run" do
  context "Substitute" do
    context "Match Tests" do
      context "No Context" do
        substitute = Fixture::Run::Substitute.build

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
