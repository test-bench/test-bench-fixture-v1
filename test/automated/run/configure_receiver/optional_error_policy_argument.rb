require_relative '../../automated_init'

context "Run" do
  context "Configure Receiver" do
    context "Optional Error Policy Argument" do
      receiver_class = Struct.new(:run)

      receiver = receiver_class.new

      run = Fixture::Run.configure(receiver, error_policy: :abort)

      test "Configures output dependency of supplied run" do
        assert(run.error_policy.instance_of?(Fixture::ErrorPolicy::Abort))
      end
    end
  end
end
