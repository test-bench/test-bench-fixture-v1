require_relative '../../automated_init'

context "Session" do
  context "Context" do
    context "Pass" do
      session = Fixture::Session.new

      return_value = session.context do
        session.assert(true)
      end

      test "Returns true" do
        assert(return_value == true)
      end
    end

    context "Failure" do
      session = Fixture::Session.new

      return_value = session.context do
        session.assert(false)
      end

      test "Returns false" do
        assert(return_value == false)
      end
    end
  end
end
