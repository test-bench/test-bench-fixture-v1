require_relative '../../automated_init'

context "Fixture" do
  context "Assert" do
    context "Positional Argument" do
      fixture = Controls::Fixture.example

      result = Controls::Result.example

      begin
        fixture.assert(result)
      rescue Fixture::AssertionFailure
      end

      test do
        assert(fixture.session.asserted?(result))
      end
    end
  end
end
