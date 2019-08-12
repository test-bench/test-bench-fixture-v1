require_relative '../../automated_init'

context "Fixture" do
  context "Actuator" do
    context "No Instance Actuator" do
      cls = Controls::Fixture::Example

      context do
        block_executed = false
        block_argument = nil
        block_context = nil

        fixture = Fixture.(cls) do |f|
          block_executed = true
          block_argument = f
          block_context = self
        end

        test "Block is executed" do
          assert(block_executed)
        end

        test "Fixture is passed as argument to block" do
          assert(block_argument == fixture)
        end

        test "Block is executed in the context of the fixture" do
          assert(block_context = fixture)
        end
      end

      context "Block Argument Omitted" do
        test "Raises error" do
          assert_raises NoMethodError do
            Fixture.(cls)
          end
        end
      end
    end
  end
end
