require_relative '../../automated_init'

context "Error Policy" do
  context "Configure Receiver" do
    context "Optional Policy Argument" do
      receiver_class = Struct.new(:error_policy)

      context "Omitted" do
        receiver = receiver_class.new

        Fixture::ErrorPolicy.configure(receiver)

        test "Selects default policy" do
          assert(receiver.error_policy.instance_of?(Fixture::ErrorPolicy::Build.policy_class))
        end
      end

      context "Given" do
        receiver = receiver_class.new

        Fixture::ErrorPolicy.configure(receiver, policy: :abort)

        test "Sets given attribute on receiver" do
          assert(receiver.error_policy.instance_of?(Fixture::ErrorPolicy::Abort))
        end
      end
    end
  end
end
