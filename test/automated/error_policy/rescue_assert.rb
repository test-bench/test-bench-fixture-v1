require_relative '../automated_init'

context "Error Policy" do
  context "Rescue Assert" do
    context "Assertion Failure" do
      assertion_failure = Fixture::AssertionFailure.build

      error_policy = Fixture::ErrorPolicy::RescueAssert.new

      test "Does not raise the assertion  failure" do
        refute_raises Fixture::AssertionFailure do
          error_policy.(assertion_failure)
        end
      end
    end

    context "Not An Assertion Failure" do
      error = Controls::Error.example

      error_policy = Fixture::ErrorPolicy::RescueAssert.new

      test "Raises the error" do
        assert_raises Controls::Error::Example do
          error_policy.(error)
        end
      end
    end
  end
end
