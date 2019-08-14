require_relative '../../automated_init'

context "Fixture" do
  context "Build" do
    context "Optional Output Argument" do
      cls = Controls::Fixture::Example

      output = Fixture::Output::Log.build

      fixture = Fixture.build(cls, output: output)

      test "Configures the given output" do
        assert(fixture.run.output.equal?(output))
      end
    end
  end
end
