require_relative '../automated_init'

context "Fixture" do
  context "Refute" do
    fixture = Controls::Fixture.example

    caller_location = Controls::CallerLocation.example

    result = Controls::Result.example

    begin
      fixture.refute(result, caller_location: caller_location)
    rescue Fixture::AssertionFailure
    end

    assertion = fixture.session.asserted?(result: !result, caller_location: caller_location)

    test do
      assert(assertion)
    end
  end
end
