require_relative '../../automated_init'

context "Session" do
  context "Fixture" do
    context "Output" do
      session = Fixture::Session.new

      fixture = Controls::Fixture::InstanceActuator.example

      session.fixture(fixture)

      test "Start fixture" do
        recorded = session.output.recorded_once?(:start_fixture) do |f|
          f == fixture
        end

        assert(recorded)
      end

      test "Finish fixture" do
        recorded = session.output.recorded_once?(:finish_fixture) do |f, r|
          f == fixture && r == true
        end

        assert(recorded)
      end
    end
  end
end
