require_relative '../../automated_init'

context "Session" do
  context "Configure Receiver" do
    receiver = Struct.new(:session).new

    return_value = Fixture::Session.configure(receiver)

    test "Supplies receiver with a session" do
      refute(receiver.session.nil?)
    end

    test "Returns the session that was supplied" do
      assert(return_value.equal?(receiver.session))
    end
  end
end
