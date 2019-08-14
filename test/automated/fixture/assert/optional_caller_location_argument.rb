require_relative '../../automated_init'

context "Fixture" do
  context "Comment" do
    context "Optional Caller Location Argument" do
      caller_location = Controls::CallerLocation.example

      context "Positional Form" do
        fixture = Controls::Fixture.example

        fixture.assert(true, caller_location: caller_location)

        test do
          assert(fixture.run.asserted?(caller_location: caller_location))
        end
      end

      context "Block Form" do
        fixture = Controls::Fixture.example

        fixture.assert(caller_location: caller_location) do
          fixture.assert(true)
        end

        test do
          assert(fixture.run.asserted?(caller_location: caller_location))
        end
      end
    end
  end
end
