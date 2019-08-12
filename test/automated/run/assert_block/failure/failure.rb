require_relative '../../../automated_init'

context "Run" do
  context "Assert Block" do
    context "Failure" do
      run = Fixture::Run.new

      test "Raises an assertion failure" do
        assert_raises(Fixture::AssertionFailure) do
          run.assert_block do
            run.assert(false)
          end
        end
      end
    end
  end
end
