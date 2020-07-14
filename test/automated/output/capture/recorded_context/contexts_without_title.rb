require_relative '../../../automated_init'

context "Output" do
  context "Capture" do
    context "Recorded Context" do
      context "Contexts Without Title" do
        capture_output = Fixture::Output::Capture.new

        capture_output.enter_context("Some Context")

        capture_output.enter_context(nil)

        record_1 = capture_output.comment("Some comment")

        capture_output.exit_context(nil, Controls::Result.example)

        record_2 = capture_output.comment("Other comment")

        capture_output.exit_context("Some Context", Controls::Result.example)

        not_included = record_1.context == ["Some Context"] &&
          record_2.context == ["Some Context"]

        test "Omitted titles aren't included in recorded context" do
          assert(not_included)
        end
      end
    end
  end
end
