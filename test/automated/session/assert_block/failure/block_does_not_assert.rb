require_relative '../../../automated_init'

context "Session" do
  context "Assert Block" do
    context "Failure" do
      context "Block Does Not Assert" do
        context "No Assertion Made By Block" do
          session = Fixture::Session.new

          test "Raises an assertion failure" do
            assert_raises(Fixture::AssertionFailure) do
              session.assert_block do
                #
              end
            end
          end
        end

        context "Block Breaks Before Assertion" do
          session = Fixture::Session.new

          test "Raises an assertion failure" do
            assert_raises(Fixture::AssertionFailure) do
              session.assert_block do
                break
                session.assert(true)
              end
            end
          end
        end
      end
    end
  end
end
