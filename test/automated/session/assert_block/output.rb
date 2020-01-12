require_relative '../../automated_init'

context "Session" do
  context "Assert Block" do
    context "Output" do
      session = Fixture::Session.new

      caller_location = Controls::CallerLocation.example

      begin
        session.assert_block(caller_location: caller_location) do
          fail
        end
      rescue RuntimeError
      end

      test "Enter assert block" do
        recorded = session.output.recorded_once?(:enter_assert_block) do |cl|
          cl == caller_location
        end

        assert(recorded)
      end

      test "Exit assert block" do
        recorded = session.output.recorded_once?(:exit_assert_block) do |cl, r|
          cl == caller_location && r == false
        end

        assert(recorded)
      end
    end
  end
end
