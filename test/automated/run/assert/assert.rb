require_relative '../../automated_init'

context "Run" do
  context "Assert" do
    context "Pass" do
      run = Fixture::Run.new

      test "Does not raise an assertion failure" do
        refute_raises(Fixture::AssertionFailure) do
          run.assert(true)
        end
      end

      test "Increments assertion counter" do
        assert(run.assertion_counter == 1)
      end

      test "Does not increment error counter" do
        assert(run.error_counter == 0)
      end
    end

    context "Failure" do
      [false, nil].each do |value|
        context "Value: #{value.inspect}" do
          run = Fixture::Run.new

          test "Raises an assertion failure" do
            assert_raises(Fixture::AssertionFailure) do
              run.assert(value)
            end
          end

          test "Increments assertion counter" do
            assert(run.assertion_counter == 1)
          end

          test "Increments error counter" do
            assert(run.error_counter == 1)
          end
        end
      end
    end
  end
end
