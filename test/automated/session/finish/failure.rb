require_relative '../../automated_init'

context "Session" do
  context "Finish" do
    context "Failure" do
      session = Fixture::Session.new

      session.fail!

      return_value = session.finish

      test "Returns false" do
        assert(return_value == false)
      end
    end
  end
end
