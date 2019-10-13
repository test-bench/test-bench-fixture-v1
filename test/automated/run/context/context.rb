require_relative '../../automated_init'

context "Run" do
  context "Context" do
    context "Pass" do
      run = Fixture::Run.new

      return_value = run.context do
        run.assert(true)
      end

      test "Returns true" do
        assert(return_value == true)
      end
    end

    context "Failure" do
      run = Fixture::Run.new

      return_value = run.context do
        run.assert(false)
      end

      test "Returns false" do
        assert(return_value == false)
      end
    end
  end
end
