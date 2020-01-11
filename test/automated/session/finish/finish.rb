require_relative '../../automated_init'

context "Session" do
  context "Finish" do
    context "Not Yet Finished" do
      session = Fixture::Session.new

      refute(session.finished?)

      session.finish

      test "Finishes the session" do
        assert(session.finished?)
      end
    end

    context "Already Finished" do
      session = Fixture::Session.new

      session.finish
      assert(session.finished?)

      test "Is an error" do
        assert_raises(Fixture::Session::Error) do
          session.finish
        end
      end
    end
  end
end
