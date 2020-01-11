require_relative '../../../automated_init'

context "Session" do
  context "Fixture" do
    context "Optional Block Argument" do
      context "Fixture Has An Instance Actuator" do
        context "Given" do
          fixture = Controls::Fixture::InstanceActuator.example
          assert(fixture.respond_to?(:call))

          session = Fixture::Session.new

          block_argument = nil

          session.fixture(fixture) do |arg|
            block_argument = arg
          end

          test "Actuates the given fixture" do
            assert(fixture.actuated?)
          end

          test "Executes the given block" do
            refute(block_argument.nil?)
          end

          test "Fixture is passed to block" do
            assert(block_argument.equal?(fixture))
          end
        end

        context "Omitted" do
          fixture = Controls::Fixture::InstanceActuator.example
          assert(fixture.respond_to?(:call))

          session = Fixture::Session.new

          test "Is not an error" do
            refute_raises(Fixture::Session::Error) do
              session.fixture(fixture)
            end
          end

          test "Actuates the given fixture" do
            assert(fixture.actuated?)
          end
        end
      end
    end
  end
end
