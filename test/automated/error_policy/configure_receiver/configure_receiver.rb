require_relative '../../automated_init'

context "Error Policy" do
  context "Configure Receiver" do
    receiver = Struct.new(:error_policy).new

    return_value = Fixture::ErrorPolicy.configure(receiver)

    test "Supplies receiver with an error policy" do
      refute(receiver.error_policy.nil?)
    end

    test "Returns the error policy that was supplied" do
      assert(return_value.equal?(receiver.error_policy))
    end
  end
end
