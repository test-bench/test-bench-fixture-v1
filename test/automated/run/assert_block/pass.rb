require_relative '../../automated_init'

context "Run" do
  context "Assert Block" do
    context "Pass" do
      run = Fixture::Run.new

      test "Does not raise an assertion failure" do
        refute_raises(Fixture::AssertionFailure) do
          run.assert_block do
            run.assert(true)
          end
        end
      end
    end
  end
end
