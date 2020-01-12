require_relative '../../../automated_init'

context "Session" do
  context "Substitute" do
    context "Match Tests" do
      context "No Test Title" do
        substitute = Fixture::Session::Substitute.build

        substitute.instance_exec do
          context "Some Context" do
            test do
              #
            end
          end
        end

        tests = substitute.match_tests("Some Context")

        test do
          assert(tests == ["Some Context"])
        end
      end
    end
  end
end
