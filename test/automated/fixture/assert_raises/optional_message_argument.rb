require_relative '../../automated_init'

context "Fixture" do
  context "Assert Raises" do
    context "Optional Message Argument" do
      error = Controls::Error.example

      context "Matches Error Message" do
        fixture = Controls::Fixture.example

        begin
          fixture.assert_raises(Controls::Error::Example, error.message) do
            raise error
          end
        rescue Fixture::AssertionFailure => assertion_failure
        end

        test "Pass" do
          assert(assertion_failure.nil?)
        end
      end

      context "Does Not Match Error Message" do
        fixture = Controls::Fixture.example

        begin
          fixture.assert_raises(Controls::Error::Example, error.message.swapcase) do
            raise error
          end
        rescue Fixture::AssertionFailure => assertion_failure
        end

        test "Failure" do
          refute(assertion_failure.nil?)
        end
      end
    end
  end
end
