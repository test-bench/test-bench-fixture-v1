require_relative '../../../automated_init'

context "Session" do
  context "Assert Block" do
    context "Failure" do
      context "Block Raises an Assertion Failure" do
        session = Fixture::Session.new

        inner_assertion_failure = nil

        begin
          session.assert_block do
            begin
              session.assert(false)
            rescue Fixture::AssertionFailure => inner_assertion_failure
              raise(inner_assertion_failure)
            end
          end
        rescue Fixture::AssertionFailure => assertion_failure
        end

        refute(assertion_failure.nil?)
        refute(inner_assertion_failure.nil?)

        test "Inner assertion failure is the cause of the block-form assertion failure" do
          assert(assertion_failure.cause == inner_assertion_failure)
        end
      end
    end
  end
end
