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

    context "Skip" do
      session = Fixture::Session.new

      return_value = session.context

      test "Returns nil" do
        assert(return_value == nil)
      end

      test "Records the skip" do
        assert(session.skip_counter > 0)
      end
    end
  end
end
