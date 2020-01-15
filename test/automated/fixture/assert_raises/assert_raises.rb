require_relative '../../automated_init'

context "Fixture" do
  context "Assert Raises" do
    caller_location = Controls::CallerLocation.example

    context "Exception Raised" do
      fixture = Controls::Fixture.example

      error = Controls::Error.example

      begin
        fixture.assert_raises(Controls::Error::Example, caller_location: caller_location) do
          raise error
        end
      rescue Fixture::AssertionFailure => assertion_failure
      end

      test "Is not an assertion failure" do
        assert(assertion_failure.nil?)
      end

      test "Assertion" do
        assertion = fixture.session.asserted?(result: true, caller_location: caller_location)

        assert(assertion)
      end
    end

    context "Exception Not Raised" do
      fixture = Controls::Fixture.example

      begin
        fixture.assert_raises(Controls::Error::Example, caller_location: caller_location) do
          #
        end
      rescue Fixture::AssertionFailure => assertion_failure
      end

      test "Is an assertion failure" do
        refute(assertion_failure.nil?)
      end

      test "Assertion" do
        assertion = fixture.session.asserted?(result: false, caller_location: caller_location)

        assert(assertion)
      end
    end
  end
end
