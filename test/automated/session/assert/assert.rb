require_relative '../../automated_init'

context "Session" do
  context "Assert" do
    context "Pass" do
      session = Fixture::Session.new

      test "Does not raise an assertion failure" do
        refute_raises(Fixture::AssertionFailure) do
          session.assert(true)
        end
      end

      test "Increments assertion counter" do
        assert(session.assertion_counter == 1)
      end
    end

    context "Failure" do
      [false, nil].each do |value|
        context "Value: #{value.inspect}" do
          session = Fixture::Session.new

          test "Raises an assertion failure" do
            assert_raises(Fixture::AssertionFailure) do
              session.assert(value)
            end
          end

          test "Increments assertion counter" do
            assert(session.assertion_counter == 1)
          end
        end
      end
    end
  end
end
