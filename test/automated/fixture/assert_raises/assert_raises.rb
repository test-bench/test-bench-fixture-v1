require_relative '../../automated_init'

context "Fixture" do
  context "Assert Raises" do
    caller_location = Controls::CallerLocation.example

    context "Exception Raised" do
      fixture = Controls::Fixture.example

      error = Controls::Error.example

      fixture.assert_raises(Controls::Error::Example, caller_location: caller_location) do
        raise error
      end

      test do
        assert(fixture.session.asserted?(true, caller_location: caller_location))
      end
    end

    context "Exception Not Raised" do
      fixture = Controls::Fixture.example

      begin
        fixture.assert_raises(Controls::Error::Example, caller_location: caller_location) do
          #
        end
      rescue Fixture::AssertionFailure
      end

      test do
        assert(fixture.session.asserted?(false, caller_location: caller_location))
      end
    end
  end
end
