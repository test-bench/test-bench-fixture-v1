require_relative '../../automated_init'

context "Session" do
  context "Substitute" do
    context "Test Predicate" do
      title = "Some test"

      context do
        substitute = Fixture::Session::Substitute.build

        substitute.test(title) do
          #
        end

        context "Result Matches" do
          test "Returns true" do
            assert(substitute.test?(title) == true)
          end
        end

        context "Result Does Not Match" do
          test "Returns false" do
            assert(substitute.test?(title.swapcase) == false)
          end
        end
      end

      context "Test Skipped" do
        substitute = Fixture::Session::Substitute.build

        substitute.test(title)

        context "Result Matches" do
          test "Returns false" do
            assert(substitute.test?(title) == false)
          end
        end
      end
    end
  end
end
