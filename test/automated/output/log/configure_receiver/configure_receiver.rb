require_relative '../../../automated_init'

context "Output" do
  context "Log" do
    context "Configure Receiver" do
      receiver = Struct.new(:output).new

      return_value = Fixture::Output::Log.configure(receiver)

      test "Configures a log output on receiver" do
        assert(receiver.output.instance_of?(Fixture::Output::Log))
      end

      test "Returns the log output" do
        assert(return_value == receiver.output)
      end
    end
  end
end
