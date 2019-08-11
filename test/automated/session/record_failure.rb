require_relative '../automated_init'

context "Session" do
  context "Record Failure" do
    session = Fixture::Session.new

    session.record_failure

    test "Failure counter is increased" do
      assert(session.failure_counter > 0)
    end
  end
end
