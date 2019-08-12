require_relative '../../automated_init'

context "Session" do
  context "Configure Receiver" do
    context "Optional Session Argument" do
      receiver_class = Struct.new(:session)

      context "Omitted" do
        receiver = receiver_class.new

        Fixture::Session.configure(receiver)

        test "Supplies receiver with a session" do
          refute(receiver.session.nil?)
        end
      end

      context "Given" do
        session = Fixture::Session.new

        receiver = receiver_class.new

        Fixture::Session.configure(receiver, session: session)

        test "Supplies receiver with the given osession" do
          assert(receiver.session.equal?(session))
        end
      end
    end
  end
end
