require_relative '../../automated_init'

context "Session" do
  context "Start" do
    context "Not Yet Started" do
      session = Fixture::Session.new
      refute(session.started?)

      session.start

      test "Starts session" do
        assert(session.started?)
      end
    end

    context "Already Started" do
      session = Fixture::Session.new

      session.start
      assert(session.started?)

      test "Is an error" do
        assert_raises(Fixture::Session::Error) do
          session.start
        end
      end
    end
  end
end
