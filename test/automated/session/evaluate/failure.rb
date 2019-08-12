require_relative '../../automated_init'

context "Session" do
  context "Evaluate" do
    context "Failure" do
      session = Fixture::Session.new

      return_value = session.evaluate(->{
        session.fail!
      })

      test "Returns false" do
        assert(return_value == false)
      end
    end
  end
end
