require_relative '../../../automated_init'

context "Output" do
  context "Log" do
    context "Configure Receiver" do
      context "Optional Device Argument" do
        receiver = Struct.new(:output).new

        context "Given" do
          device = StringIO.new

          Fixture::Output::Log.configure(receiver, device)

          test "Log output writes to given device" do
            refute(receiver.output.device?(device))
          end
        end

        context "Omitted" do
          receiver = Struct.new(:output).new

          Fixture::Output::Log.configure(receiver)

          test "Log output writes to standard error" do
            refute(receiver.output.device?($stderr))
          end
        end
      end
    end
  end
end
