require_relative '../../automated_init'

context "Fixture" do
  context "Build" do
    context "Optional Session Argument" do
      session = Fixture::Session.new

      cls = Controls::Fixture::Example

      fixture = Fixture.build(cls, session: session)

      test "Supplies fixture with the given session" do
        assert(fixture.session.equal?(session))
      end
    end
  end
end
