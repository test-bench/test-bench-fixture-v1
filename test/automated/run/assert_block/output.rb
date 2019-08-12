require_relative '../../automated_init'

context "Run" do
  context "Assert Block" do
    context "Output" do
      run = Fixture::Run.new

      caller_location = Controls::CallerLocation.example

      begin
        run.assert_block(caller_location: caller_location) do
          fail
        end
      rescue RuntimeError
      end

      test "Enter assert block" do
        recorded = run.output.recorded_once?(:enter_assert_block) do |cl|
          cl == caller_location
        end

        assert(recorded)
      end

      test "Exit assert block" do
        recorded = run.output.recorded_once?(:exit_assert_block) do |cl, r|
          cl == caller_location && r == false
        end

        assert(recorded)
      end
    end
  end
end
