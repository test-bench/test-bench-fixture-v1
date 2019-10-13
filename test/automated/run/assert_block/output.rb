require_relative '../../automated_init'

context "Run" do
  context "Assert Block" do
    context "Output" do
      run = Fixture::Run.new

      begin
        run.assert_block do
          fail
        end
      rescue RuntimeError
      end

      test "Enter assert block" do
        recorded = run.output.recorded_once?(:enter_assert_block)

        assert(recorded)
      end

      test "Exit assert block" do
        recorded = run.output.recorded_once?(:exit_assert_block) do |r|
          r == false
        end

        assert(recorded)
      end
    end
  end
end
