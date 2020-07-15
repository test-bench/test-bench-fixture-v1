require_relative '../automated_init'

context "Session" do
  context "Fail" do
    session = Fixture::Session.new

    session.fail!

    test "Assertion counter is increased" do
      assert(session.assertion_counter > 0)
    end

    test "Error counter is increased" do
      assert(session.error_counter > 0)
    end
  end
end
