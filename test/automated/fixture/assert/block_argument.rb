require_relative '../../automated_init'

context "Fixture" do
  context "Comment" do
    context "Block Argument" do
      context "Pass" do
        fixture = Controls::Fixture.example

        test "Does not raise an assertion failure" do
          refute_raises(Fixture::AssertionFailure) do
            fixture.assert(true)
          end
        end
      end

      context "Failure" do
        fixture = Controls::Fixture.example

        test "Raises an assertion failure" do
          assert_raises(Fixture::AssertionFailure) do
            fixture.assert(false)
          end
        end
      end
    end
  end
end
