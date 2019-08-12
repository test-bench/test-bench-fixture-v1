require_relative '../../automated_init'

context "Fixture" do
  context "Actuator" do
    context "No Instance Actuator" do
      cls = Controls::Fixture::InstanceActuator::Non::Example

      block_executed = false

      fixture = Fixture.(cls) do
        block_executed = true
      end

      test "Block is executed" do
        assert(block_executed == true)
      end
    end
  end
end
