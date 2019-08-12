require_relative '../../automated_init'

context "Fixture" do
  context "Actuator" do
    context "Instance Actuator" do
      cls = Controls::Fixture::InstanceActuator::Example

      context do
        fixture = Fixture.(cls)

        test "Instance actuator is called" do
          assert(fixture.actuated?)
        end
      end

      context "Block Argument Given" do
        fixture = Fixture.(cls) do
          #
        end

        test "Instance actuator is not called" do
          refute(fixture.actuated?)
        end
      end
    end
  end
end
