require_relative '../../automated_init'

context "Fixture" do
  context "Actuator" do
    context "Instance Actuator" do
      cls = Controls::Fixture::InstanceActuator::Example

      fixture = Fixture.(cls)

      test "Instance actuator is called" do
        assert(fixture.actuated?)
      end
    end
  end
end
