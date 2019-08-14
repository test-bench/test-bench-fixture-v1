require_relative '../../automated_init'

context "Fixture" do
  context "Assert Raises" do
    context "Optional Message Argument" do
      error = Controls::Error.example

      context "Matches Error Message" do
        fixture = Controls::Fixture.example

        fixture.assert_raises(Controls::Error::Example, error.message) do
          raise error
        end

        test "Passes" do
          refute(fixture.run.failed?)
        end
      end

      context "Does Not Match Error Message" do
        fixture = Controls::Fixture.example

        begin
          fixture.assert_raises(Controls::Error::Example, error.message.swapcase) do
            raise error
          end
        rescue Fixture::AssertionFailure
        end

        test "Fails" do
          assert(fixture.run.failed?)
        end
      end
    end
  end
end
