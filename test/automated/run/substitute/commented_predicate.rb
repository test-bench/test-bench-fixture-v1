require_relative '../../automated_init'

context "Run" do
  context "Substitute" do
    context "Commented Predicate" do
      text = "Some comment"

      context "Comment" do
        substitute = Fixture::Run::Substitute.build

        substitute.comment(text)

        context "Text Matches" do
          test "Returns true" do
            assert(substitute.commented?(text))
          end
        end

        context "Text Does Not Match" do
          test "Returns false" do
            refute(substitute.commented?(text.swapcase))
          end
        end
      end

      context "No Comment" do
        substitute = Fixture::Run::Substitute.build

        test "Returns false" do
          refute(substitute.commented?(text))
        end
      end
    end
  end
end
