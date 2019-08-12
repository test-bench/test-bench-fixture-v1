require_relative '../../automated_init'

context "Session" do
  context "Assert Block" do
    context "Pass" do
      session = Fixture::Session.new

      test "Does not raise an assertion failure" do
        refute_raises(Fixture::AssertionFailure) do
          session.assert_block do
            session.assert(true)
          end
        end
      end
    end
  end
end
