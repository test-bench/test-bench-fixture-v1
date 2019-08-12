require_relative '../../../automated_init'

context "Evaluate" do
  context "Block Argument" do
    context "Rescue Error Policy" do
      run = Fixture::Run.new

      Fixture::ErrorPolicy.configure(run, policy: :rescue)

      error_argument = :not_set

      result = run.evaluate(->{ fail }) do |_, err|
        error_argument = err
      end

      test "Does not supply raised error to block" do
        assert(error_argument.nil?)
      end
    end
  end
end
