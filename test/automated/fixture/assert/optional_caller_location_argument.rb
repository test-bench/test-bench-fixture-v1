require_relative '../../automated_init'

context "Fixture" do
  context "Comment" do
    context "Optional Caller Location Argument" do
      caller_location = Controls::CallerLocation.example

      fixture = Controls::Fixture.example

      fixture.assert(true, caller_location: caller_location)

      test do
        assert(fixture.session.asserted?(caller_location: caller_location))
      end
    end
  end
end
