require_relative '../../automated_init'

context "Session" do
  context "Finish" do
    context "Pass" do
      session = Fixture::Session.new

      return_value = session.finish

      test "Returns true" do
        assert(return_value == true)
      end
    end
  end
end
