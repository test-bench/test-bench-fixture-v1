require_relative '../../automated_init'

context "Fixture" do
  context "Fixture (Instance Method)" do
    context "Optional Block Argument" do
      fixture_cls = Controls::Fixture::InstanceActuator::Example

      context "Omitted" do
        fixture = Controls::Fixture.example

        executed_fixture = fixture.fixture(Controls::Fixture::InstanceActuator::Example)

        test "Actuates the fixture instance" do
          assert(executed_fixture.actuated?)
        end
      end

      context "Block Given" do
        fixture = Controls::Fixture.example

        block_executed = false

        executed_fixture = fixture.fixture(Controls::Fixture::InstanceActuator::Example) do
          block_executed = true
        end

        test "Does not actuate the fixture instance" do
          refute(executed_fixture.actuated?)
        end

        test "Executes block" do
          assert(block_executed)
        end
      end
    end
  end
end
