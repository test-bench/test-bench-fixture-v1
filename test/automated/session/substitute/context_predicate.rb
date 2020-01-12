require_relative '../../automated_init'

context "Session" do
  context "Substitute" do
    context "Context Predicate" do
      title = "Some Context"

      context do
        substitute = Fixture::Session::Substitute.build

        substitute.context(title) do
          #
        end

        context "Result Matches" do
          test "Returns true" do
            assert(substitute.context?(title) == true)
          end
        end

        context "Result Does Not Match" do
          test "Returns false" do
            assert(substitute.context?(title.swapcase) == false)
          end
        end
      end

      context "Context Skipped" do
        substitute = Fixture::Session::Substitute.build

        substitute.context(title)

        context "Result Matches" do
          test "Returns false" do
            assert(substitute.context?(title) == false)
          end
        end
      end
    end
  end
end
