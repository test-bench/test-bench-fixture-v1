require_relative '../../automated_init'

context "Session" do
  context "Fixture" do
    context "Failure" do
      session = Fixture::Session.new

      fixture = Controls::Fixture.example

      return_value = session.fixture(fixture) do
        session.assert(false)
      end

      test "Returns false" do
        assert(return_value == false)
      end
    end
  end
end
