require_relative '../../automated_init'

context "Session" do
  context "Evaluate" do
    context "Pass" do
      session = Fixture::Session.new

      return_value = session.evaluate(->{})

      test "Returns true" do
        assert(return_value == true)
      end
    end
  end
end
