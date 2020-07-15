require_relative '../../automated_init'

context "Session" do
  context "Start" do
    context "Output" do
      session = Fixture::Session.new

      session.start

      test "Records the session start to the output" do
        recorded = session.output.start_recorded_once?

        assert(recorded)
      end
    end
  end
end
