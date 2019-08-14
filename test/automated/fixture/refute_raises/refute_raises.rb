require_relative '../../automated_init'

context "Fixture" do
  context "Refute Raises" do
    caller_location = Controls::CallerLocation.example

    error = Controls::Error.example

    context "Possible Error Not Raised" do
      fixture = Controls::Fixture.example

      fixture.refute_raises(Controls::Error::Example, caller_location: caller_location) do
        #
      end

      test do
        assert(fixture.session.asserted?(true, caller_location: caller_location))
      end
    end

    context "Possible Error Raised" do
      fixture = Controls::Fixture.example

      begin
        fixture.refute_raises(Controls::Error::Example, caller_location: caller_location) do
          raise error
        end
      rescue Fixture::AssertionFailure
      end

      test do
        assert(fixture.session.asserted?(false, caller_location: caller_location))
      end
    end
  end
end
