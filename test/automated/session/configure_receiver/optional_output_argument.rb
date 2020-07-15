require_relative '../../automated_init'

context "Session" do
  context "Configure Receiver" do
    context "Optional Output Argument" do
      receiver = Struct.new(:session).new

      context "Given" do
        output = Fixture::Output::Log.build

        session = Fixture::Session.configure(receiver, output: output)

        test "Assigns given output to session" do
          assert(session.output.equal?(output))
        end
      end

      context "Omitted" do
        session = Fixture::Session.configure(receiver)

        test "Assigns logging output to session" do
          assert(session.output.instance_of?(Fixture::Output::Log))
        end
      end
    end
  end
end
