require_relative '../../automated_init'

context "Run" do
  context "Configure Receiver" do
    context "Optional Output Argument" do
      receiver = Struct.new(:run).new

      context "Given" do
        output = Fixture::Output::Log.build

        run = Fixture::Run.configure(receiver, output: output)

        test "Assigns given output to run" do
          assert(run.output.equal?(output))
        end
      end

      context "Omitted" do
        run = Fixture::Run.configure(receiver)

        test "Assigns logging output to run" do
          assert(run.output.instance_of?(Fixture::Output::Log))
        end
      end
    end
  end
end
