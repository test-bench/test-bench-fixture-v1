require_relative '../../automated_init'

context "Fixture" do
  context "Refute Raises" do
    caller_location = Controls::CallerLocation.example

    error = Controls::Error.example

    context "Prohibited Error Not Raised" do
      fixture = Controls::Fixture.example

      begin
        fixture.refute_raises(Controls::Error::Example, caller_location: caller_location) do
          #
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

    context "Prohibited Error Raised" do
      fixture = Controls::Fixture.example

      begin
        fixture.refute_raises(Controls::Error::Example, caller_location: caller_location) do
          raise error
        end
      rescue Fixture::AssertionFailure => assertion_failure
      end

      test "Is an assertion failure" do
        refute(assertion_failure.nil?)
      end

      test "Cause not set on assertion failure exception" do
        assert(assertion_failure.cause.nil?)
      end

      test "Assertion" do
        assertion = fixture.session.asserted?(result: false, caller_location: caller_location)

        assert(assertion)
      end
    end
  end
end
