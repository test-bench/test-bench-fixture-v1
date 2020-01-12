require_relative '../../automated_init'

context "Session" do
  context "Start" do
    context "Output" do
      session = Fixture::Session.new

      session.start

      test "Records the session start to the output" do
        recorded = session.output.recorded_once?(:start)

        assert(recorded)
      end
    end
  end
end
