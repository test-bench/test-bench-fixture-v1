require_relative '../../../automated_init'

context "Session" do
  context "Fixture" do
    context "Optional Block Argument" do
      context "Fixture Does Not Have An Instance Actuator" do
        context "Given" do
          fixture = Controls::Fixture::InstanceActuator::Non.example
          refute(fixture.respond_to?(:call))

          session = Fixture::Session.new

          block_argument = nil

          session.fixture(fixture) do |arg|
            block_argument = arg
          end

          test "Executes the given block" do
            refute(block_argument.nil?)
          end

          test "Fixture is passed to block" do
            assert(block_argument.equal?(fixture))
          end
        end

        context "Omitted" do
          fixture = Controls::Fixture::InstanceActuator::Non.example
          refute(fixture.respond_to?(:call))

          session = Fixture::Session.new

          test "Is an error" do
            assert_raises(Fixture::Session::Error) do
              session.fixture(fixture)
            end
          end
        end
      end
    end
  end
end
