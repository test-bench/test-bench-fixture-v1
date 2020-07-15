require_relative '../../../automated_init'

context "Output" do
  context "Capture" do
    context "Recorded Context" do
      capture_output = Fixture::Output::Capture.new

      capture_output.enter_context("Context #1")

      capture_output.enter_context("Context #2")

      capture_output.enter_context("Context #3")
      capture_output.exit_context("Context #3", Controls::Result.example)

      Controls::Output::Exercise.each_method do |method_name, args|
        context "Method: #{method_name}" do
          record = capture_output.public_send(method_name, *args)

          recorded = record.context == ["Context #1", "Context #2"]

          test "Recorded" do
            assert(recorded)
          end
        end
      end
    end
  end
end
