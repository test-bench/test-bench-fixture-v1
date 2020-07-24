require_relative '../../automated_init'

context "Output" do
  context "Multiple" do
    context "Register Output" do
      multiple = Fixture::Output::Multiple.new

      output = Fixture::Controls::Output.example
      refute(multiple.registered?(output))

      multiple.register(output)

      test "Output is registered" do
        assert(multiple.registered?(output))
      end
    end
  end
end
