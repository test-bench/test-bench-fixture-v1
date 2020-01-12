require_relative '../../../automated_init'

context "Session" do
  context "Assert Block" do
    context "Failure" do
      session = Fixture::Session.new

      test "Raises an assertion failure" do
        assert_raises(Fixture::AssertionFailure) do
          session.assert_block do
            session.fail!

            session.assert(true)
          end
        end
      end

      test "Output indicates assert block failed" do
        assert_block_failed = session.output.recorded_once?(:exit_assert_block) do |_, r|
          r == false
        end

        assert(assert_block_failed)
      end
    end
  end
end
