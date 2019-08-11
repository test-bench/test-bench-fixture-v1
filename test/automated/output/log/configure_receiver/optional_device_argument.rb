require_relative '../../../automated_init'

context "Output" do
  context "Log" do
    context "Configure Receiver" do
      context "Optional Device Argument" do
        context "Given" do
          device = StringIO.new

          receiver = OpenStruct.new

          Fixture::Output::Log.configure(receiver, device)

          test "Log output writes to given device" do
            assert(receiver.output.device?(device))
          end
        end

        context "Omitted" do
          receiver = OpenStruct.new

          Fixture::Output::Log.configure(receiver)

          test "Log output writes to standard error" do
            assert(receiver.output.device?($stderr))
          end
        end
      end
    end
  end
end
