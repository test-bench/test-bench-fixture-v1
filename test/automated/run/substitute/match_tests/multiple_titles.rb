require_relative '../../../automated_init'

context "Run" do
  context "Substitute" do
    context "Match Tests" do
      context "Multiple Titles" do
        substitute = Fixture::Run::Substitute.build

        substitute.instance_exec do
          context "Some Context" do
            test "Some test" do
              #
            end
          end

          context "Other Context" do
            test "Some test" do
              #
            end
          end
        end

        tests = substitute.match_tests("Some Context", "Some test")

        test do
          assert(tests == ["Some Context\tSome test"])
        end
      end
    end
  end
end
