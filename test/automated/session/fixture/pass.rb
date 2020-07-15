require_relative '../../automated_init'

context "Session" do
  context "Fixture" do
    context "Pass" do
      session = Fixture::Session.new

      fixture = Controls::Fixture.example

      return_value = session.fixture(fixture) do
        session.assert(true)
      end

      test "Returns true" do
        assert(return_value == true)
      end
    end
  end
end
