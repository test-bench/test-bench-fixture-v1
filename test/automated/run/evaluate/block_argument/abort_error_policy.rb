require_relative '../../../automated_init'

context "Evaluate" do
  context "Block Argument" do
    context "Abort Error Policy" do
      run = Fixture::Run.new

      Fixture::ErrorPolicy.configure(run, policy: :abort)

      error_argument = :not_set

      begin
        result = run.evaluate(->{ fail }) do |_, err|
          error_argument = err
        end
      rescue SystemExit => system_exit
      end

      refute(system_exit.nil?)

      test "Supplies the raised error to block" do
        assert(error_argument == system_exit)
      end
    end
  end
end
