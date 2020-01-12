require_relative '../../../automated_init'

context "Session" do
  context "Assert Block" do
    context "Failure" do
      session = Fixture::Session.new

      test "Raises an assertion failure" do
        assert_raises(Fixture::AssertionFailure) do
          session.assert_block do
            session.assert(false)
          end
        end
      end
    end
  end
end
