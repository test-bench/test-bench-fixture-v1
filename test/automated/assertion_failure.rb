require_relative './automated_init'

context "Failures" do
  context "Assertion Failure" do
    caller_location = Controls::CallerLocation.example

    assertion_failure = Fixture::AssertionFailure.build(caller_location)

    test "Backtrace" do
      assert(assertion_failure.backtrace == [caller_location.to_s])
    end
  end
end
