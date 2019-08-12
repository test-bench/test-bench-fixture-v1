require_relative '../../../automated_init'

context "Run" do
  context "Assert Block" do
    context "Failure" do
      context "Block Does Not Assert" do
        context "No Assertion Made By Block" do
          run = Fixture::Run.new

          test "Raises an assertion failure" do
            assert_raises(Fixture::AssertionFailure) do
              run.assert_block do
                #
              end
            end
          end
        end

        context "Block Breaks Before Assertion" do
          run = Fixture::Run.new

          test "Raises an assertion failure" do
            assert_raises(Fixture::AssertionFailure) do
              run.assert_block do
                break
                run.assert(true)
              end
            end
          end
        end
      end
    end
  end
end
