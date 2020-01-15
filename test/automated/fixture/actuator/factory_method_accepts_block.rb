require_relative '../../automated_init'

context "Fixture" do
  context "Actuator" do
    context "Factory Method Accepts Block" do
      cls = Controls::Fixture.example_class do
        attr_reader :blk

        def initialize(blk)
          @blk = blk
        end

        def self.build(&blk)
          new(blk)
        end

        def call
        end
      end

      block_executed = false

      block_executions = 0

      fixture = Fixture.(cls) do
        block_executed = true
        block_executions += 1
      end

      test "Block is passed to fixture's constructor" do
        fixture.blk.()

        assert(block_executed == true)
      end

      test "Block is not executed again when fixture is actuated" do
        assert(block_executions == 1)
      end
    end
  end
end
