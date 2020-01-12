require_relative '../../automated_init'

context "Session" do
  context "Fixture" do
    session = Fixture::Session.new

    fixture = Controls::Fixture::InstanceActuator.example

    session.fixture(fixture)

    test "Actuates the fixture" do
      assert(fixture.actuated?)
    end
  end
end
