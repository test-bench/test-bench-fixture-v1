require_relative '../../automated_init'

context "Session" do
  context "Configure Receiver" do
    context "Optional Error Policy Argument" do
      receiver_class = Struct.new(:session)

      receiver = receiver_class.new

      session = Fixture::Session.configure(receiver, error_policy: :abort)

      test "Configures output dependency of supplied session" do
        assert(session.error_policy.instance_of?(Fixture::ErrorPolicy::Abort))
      end
    end
  end
end
