require_relative '../../automated_init'

context "Run" do
  context "Configure Receiver" do
    context "Optional Run Argument" do
      receiver_class = Struct.new(:run)

      context "Omitted" do
        receiver = receiver_class.new

        Fixture::Run.configure(receiver)

        test "Supplies receiver with a run" do
          refute(receiver.run.nil?)
        end
      end

      context "Given" do
        run = Fixture::Run.new

        receiver = receiver_class.new

        Fixture::Run.configure(receiver, run: run)

        test "Supplies receiver with the given orun" do
          assert(receiver.run.equal?(run))
        end
      end
    end
  end
end
