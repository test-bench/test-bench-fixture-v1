require_relative '../automated_init'

context "Session" do
  context "Record Skip" do
    session = Fixture::Session.new

    session.record_skip

    test "Skip counter is increased" do
      assert(session.skip_counter > 0)
    end
  end
end
