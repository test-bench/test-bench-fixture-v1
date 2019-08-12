require_relative '../../automated_init'

context "Run" do
  context "Configure Receiver" do
    receiver = Struct.new(:run).new

    return_value = Fixture::Run.configure(receiver)

    test "Supplies receiver with a run" do
      refute(receiver.run.nil?)
    end

    test "Returns the run that was supplied" do
      assert(return_value.equal?(receiver.run))
    end
  end
end
